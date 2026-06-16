
import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
    
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
        
        //                Task {
        //                    do {
        //                        let events = try await APIClient.shared.getAllEvents(sport: sport.urlKey)
        //                        await MainActor.run {
        //                            setTableViewData(data: events)
        //                        }
        //                    } catch {
        //                        Alerts.showFetchError(on: self)
        //                    }
        //                }
        APIClient.shared.getAllEventsOld(sport: sport.urlKey) { [weak self] events in
            DispatchQueue.main.async {
                guard let self = self else {return}
                
                if let fetched = events {
                    self.setTableViewData(data: fetched)
                } else {
                    Alerts.showFetchError(on: self)
                }
            }
        }
    }
    
    func setTableViewData(data: [Event]) {
        
        let grouped = Swift.Dictionary(grouping: data) { $0.league.id }
        
        let finalSections: [Section] = grouped.compactMap { (key, events) in
            guard let firstLeague = events.first?.league else {
                return nil
            }
            return Section(header: .league(firstLeague), events: events)
        }
        
        let sortedSections = finalSections.sorted { (section1: Section, section2: Section) in
            if case .league(let league1) = section1.header,
               case .league(let league2) = section2.header {
                return league1.id < league2.id
            }
            return false
        }
        
        let leagues = Array(Set(data.map { $0.league.id }))
            .compactMap { id in data.first { $0.league.id == id }?.league }
        
        do {
            try DatabaseManager.shared.saveLeagues(leagues)
            try DatabaseManager.shared.saveEvents(data)
        } catch {
            print("DB error: \(error)")
        }
        
        tableView.set(sections: sortedSections)
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
