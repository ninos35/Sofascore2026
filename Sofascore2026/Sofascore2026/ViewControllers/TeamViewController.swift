
import UIKit
import SnapKit

class TeamViewController: UIViewController {
    
    private let headerView: DisplayHeaderView = DisplayHeaderView()
    
    private let tabs: [Constants.Tabs] = [.details, .squad]
    
    private let tabsStackView: UIStackView = UIStackView()
    
    private let teamDetailsView: TeamDetailsView = TeamDetailsView()
    private let playersTableView: PlayersTableView = PlayersTableView()
    
    private var team: Team?
    private var currentSport: Sport?
    private var players: [Player]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        gestureRecognisers()
        
        playersTableView.setupTableView()
        
        loadDetailsData()
    }
    
    func addViews() {
        
        view.addSubview(headerView)
        view.addSubview(tabsStackView)
        view.addSubview(teamDetailsView)
        view.addSubview(playersTableView)
        
        addTabs()
    }
    
    func styleViews() {
        view.backgroundColor = Constants.Colors.lightBlue
        
        playersTableView.isHidden = true
        
        tabsStackView.backgroundColor = Constants.Colors.lightBlue
        tabsStackView.axis = .horizontal
        tabsStackView.distribution = .fillEqually
    }
    
    func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        tabsStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        teamDetailsView.snp.makeConstraints { make in
            make.top.equalTo(tabsStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        playersTableView.snp.makeConstraints { make in
            make.top.equalTo(tabsStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func gestureRecognisers() {
        headerView.onTappedBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        teamDetailsView.onLeagueSelected = { [weak self] league in
            guard let self = self else { return }
            
            let tournamentViewController: TournamentViewController = TournamentViewController()
            tournamentViewController.set(tournament: league, sport: currentSport ?? .football)
            self.navigationController?.pushViewController(tournamentViewController, animated: true)
        }
    }
    func addTabs() {
        for (index,tab) in tabs.enumerated() {
            let tabView: TabView = TabView()
            tabView.set(tab: tab)
            if  index == 0 {
                tabView.isSelected = true
            }
            tabsStackView.addArrangedSubview(tabView)
            
            tabView.stateChanged = { [weak self] clickedTab in
                if clickedTab.isSelected {
                    self?.changeTab(clicked: clickedTab)
                }
            }
        }
    }
    
    func changeTab(clicked: TabView) {
        for subview in tabsStackView.arrangedSubviews {
            if let otherTabView = subview as? TabView,
               otherTabView != clicked {
                otherTabView.isSelected = false
            }
        }
        guard let tabType = clicked.type else { return }
        
        if tabType == .details {
            playersTableView.isHidden = true
            teamDetailsView.isHidden = false
            loadDetailsData()
        } else {
            teamDetailsView.isHidden = true
            playersTableView.isHidden = false
            loadSquadData()
        }
        
    }
    
    private func loadDetailsData() {
        Task {
            do {
                let teamInfo: TeamInfo = try await APIClient.shared.getTeamInfo(id: Int(team!.id))
                let teamPlayers: [Player] = try await APIClient.shared.getTeamPlayers(id: Int(team!.id))
                let tournaments: [League] = try await APIClient.shared.getTeamTournaments(id: Int(team!.id))
                await MainActor.run {
                    
                    self.players = teamPlayers
                    let totalCount: Int = teamPlayers.count
                    let foreignCount: Int = teamPlayers.filter { $0.isForeign == true }.count
                    
                    teamDetailsView.set(teamInfo: teamInfo)
                    teamDetailsView.set(totalPlayers: totalCount, foreignPlayers: foreignCount)
                    teamDetailsView.set(tournaments: tournaments)
                    teamDetailsView.set(venue: teamInfo.venue!)
                }
            } catch {
                Alerts.showFetchError(on: self)
            }
        }
    }
    
    private func loadSquadData() {
        guard let loadedPlayers = self.players else {
            loadDetailsData()
            return
        }
        let playersSection: PlayersSection = PlayersSection(players: loadedPlayers)
        
        playersTableView.set(players: [playersSection])
    }
    
    func set(team: Team, sport: Sport) {
        headerView.set(team: team)
        self.team = team
        self.currentSport = sport
    }
}
