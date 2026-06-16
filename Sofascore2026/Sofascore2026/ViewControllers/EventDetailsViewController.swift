
import UIKit
import SnapKit
import SofaAcademic

class EventDetailsViewController: UIViewController {
    
    private var currentSport: Sport = .football
    
    private let detailedMatchView: DetailedMatchView = DetailedMatchView()
    private let incidentTableView: IncidentTableView = IncidentTableView()
    
    private let noIncidentView: NoIncidentView = NoIncidentView()
    
    private let backButtonView: UIView = UIView()
    private let backImageView: UIImageView = UIImageView()
    
    private let titleView: UIView = UIView()
    private let titleImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        setupNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()
        gestureRecognisers()
        
        incidentTableView.setupTableView(sport: currentSport)
    }
    
    func addViews() {
        view.addSubview(detailedMatchView)
        view.addSubview(incidentTableView)
        view.addSubview(noIncidentView)
        
        backButtonView.addSubview(backImageView)
        
        titleView.addSubview(titleImageView)
        titleView.addSubview(titleLabel)
    }
    
    func styleViews() {
        view.backgroundColor = Constants.Colors.systemGray
        
        backImageView.image = UIImage(named: Constants.Vectors.backArrow)
        backImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = Constants.Fonts.regularCondensed
        titleLabel.textColor = Constants.Colors.gray
        
        noIncidentView.isHidden = true
    }
    
    func setupConstraints() {
        detailedMatchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(112)
        }
        incidentTableView.snp.makeConstraints { make in
            make.top.equalTo(detailedMatchView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        noIncidentView.snp.makeConstraints { make in
            make.top.equalTo(detailedMatchView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        titleImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleImageView.snp.trailing).offset(8)
            make.top.bottom.equalToSuperview()
        }
        backImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(16)
        }
    }
    
    func setupGestureRecognizers() {
        backImageView.isUserInteractionEnabled = true
        let backTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedBack))
        backImageView.addGestureRecognizer(backTapGesture)
    }
    
    @objc func clickedBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchIncidents(for id: Int64) {
        Task {
            do {
                let incidents: [Incident] = try await APIClient.shared.getIncidents(id: id)
                
                await MainActor.run {
                    setTableViewData(data: incidents)
                }
            } catch {
                Alerts.showFetchError(on: self)
            }
        }
    }
    
    func setTableViewData(data: [Incident]) {
        if data.isEmpty {
            noIncidentView.isHidden = false
            return
        }
        
        let chronological: [Incident] = data.sorted { $0.minute < $1.minute }
        
        var currentHomeScore: Int32 = 0
        var currentAwayScore: Int32 = 0
        
        let incidents: [Incident] = chronological.map { incident in
            var i = incident
            
            if incident.type == .goal {
                if incident.isHomeTeam == true {
                    currentHomeScore += incident.scoreDiff ?? 0
                } else {
                    currentAwayScore += incident.scoreDiff ?? 0
                }
            }
            
            i.homeScore = currentHomeScore
            i.awayScore = currentAwayScore
            
            return i
        }
        
        let section: IncidentSection = IncidentSection(incidents: incidents.reversed())
        incidentTableView.set(sections: [section])
    }
    
    func gestureRecognisers() {
        detailedMatchView.onTeamSelected = { [weak self] selected in
            guard let self = self else { return }
            let teamViewController: TeamViewController = TeamViewController()
            teamViewController.set(team: selected, sport: currentSport)
            self.navigationController?.pushViewController(teamViewController, animated: true)
        }
        noIncidentView.showLeague = { [weak self] league in
            guard let self = self else { return }
            let tournamentViewController: TournamentViewController = TournamentViewController()
            tournamentViewController.set(tournament: league, sport: currentSport)
            self.navigationController?.pushViewController(tournamentViewController, animated: true)
        }
    }
    
    func getTitle(match: Event) -> String {
        let sportName: String = self.currentSport.name
        let countryName: String = match.league.country?.name ?? ""
        let leagueName: String = match.league.name
        let round: String = match.round?.toString() ?? ""
        return sportName + ", " + countryName + ", " + leagueName + ", Round " + round
    }
    
    func setEventDetails(match: Event, sport: Sport) {
        
        self.currentSport = sport
        
        titleImageView.setUrlImage(logoUrl: match.league.logoUrl)
        
        titleLabel.text = getTitle(match: match)
        
        detailedMatchView.set(detailedMatch: match)
        noIncidentView.set(league: match.league)
        
        fetchIncidents(for: match.id)
    }
    
    func setupNavBar() {
        let backButton: UIBarButtonItem = UIBarButtonItem(customView: backButtonView)
        
        self.navigationItem.titleView = titleView
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
        backButton.hidesSharedBackground = true
        
        let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
