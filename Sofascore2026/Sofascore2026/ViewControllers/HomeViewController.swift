
import UIKit
import SnapKit
import SofaAcademic

class HomeViewController: UIViewController {
    
    private let sports: [Sport] = [.football,.basketball,.americanFootball]
    
    private var currentSport: Sport = .football
    
    private let topSectionView: TopSectionView = TopSectionView()
    
    private let tableView: EventTableView = EventTableView()
    
    private let leagueView: LeagueView = LeagueView()
    
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
        
        topSectionView.set(sports: sports)
        
        tableView.setupTableView()
        loadData(for: .football)
    }
    
    func addViews(){
        view.addSubview(topSectionView)
        view.addSubview(tableView)
    }
    
    func styleViews(){
        view.backgroundColor = Constants.Colors.lightBlue
    }
    
    func setupConstraints(){
        topSectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(96)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topSectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func loadData(for sport: Sport) {
        
        self.currentSport = sport
        
        Task {
            do {
                let events = try await HomeDataLoader.loadAllEvents(for: currentSport)
                
                let sortedSections = HomeHelper.groupAndSortEvents(events)
                HomeHelper.saveToDatabase(events: events)
                
                await MainActor.run {
                    self.tableView.set(sections: sortedSections)
                }
            } catch {
                Alerts.showFetchError(on: self)
            }
        }
    }
    
    func gestureRecognisers() {
        topSectionView.settingsClicked = { [weak self] in
            let settingsViewController: SettingsViewController = SettingsViewController()
            settingsViewController.modalPresentationStyle = .fullScreen
            self?.present(settingsViewController,animated: true)
        }
        
        tableView.selectedEvent = { [weak self] selectedMatch in
            guard let self = self else { return }
            let eventDetailsViewController: EventDetailsViewController = EventDetailsViewController()
            eventDetailsViewController.setEventDetails(match: selectedMatch, sport: self.currentSport)
            self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
        }
        
        tableView.selectedLeague = { [weak self] selectedLeague in
            guard let self = self else { return }
            let tournamentViewController: TournamentViewController = TournamentViewController()
            tournamentViewController.set(tournament: selectedLeague, sport: self.currentSport)
            self.navigationController?.pushViewController(tournamentViewController, animated: true)
        }
        
        topSectionView.changeSportData = { [weak self] selectedSport in
            self?.loadData(for: selectedSport)
        }
    }
}
