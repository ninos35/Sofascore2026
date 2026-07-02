
import UIKit
import SnapKit

class TournamentViewController: UIViewController {
    
    private let headerView: DisplayHeaderView = DisplayHeaderView()
    
    private let tabs: [Constants.Tabs] = [.matches, .standings]
    
    private let tabsStackView: UIStackView = UIStackView()
    
    private let matchesTableView: EventTableView = EventTableView()
    private let standingsTableView: StandingsTableView = StandingsTableView()
    
    private var tournament: League?
    private var currentSport: Sport = .football
    private var teamStreaks: [Int: String] = [:]
    
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
        
        standingsTableView.setupTableView(sport: currentSport)
        matchesTableView.setupTableView()
    }
    
    func addViews() {
        view.addSubview(headerView)
        view.addSubview(tabsStackView)
        view.addSubview(matchesTableView)
        view.addSubview(standingsTableView)
        
        addTabs()
    }
    
    func styleViews() {
        view.backgroundColor = Constants.Colors.lightBlue
        
        standingsTableView.isHidden = true
        
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
        matchesTableView.snp.makeConstraints { make in
            make.top.equalTo(tabsStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        standingsTableView.snp.makeConstraints { make in
            make.top.equalTo(tabsStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func gestureRecognisers() {
        headerView.onTappedBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        matchesTableView.selectedEvent = { [weak self] selectedMatch in
            guard let self = self else { return }
            let eventDetailsViewController: EventDetailsViewController = EventDetailsViewController()
            eventDetailsViewController.setEventDetails(match: selectedMatch, sport: self.currentSport)
            self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
        }
        standingsTableView.selectedTeam = { [weak self] selectedTeam in
            guard let self = self else { return }
            let teamViewController: TeamViewController = TeamViewController()
            teamViewController.set(team: selectedTeam, sport: currentSport)
            self.navigationController?.pushViewController(teamViewController, animated: true)
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
        
        if tabType == .matches {
            standingsTableView.isHidden = true
            matchesTableView.isHidden = false
            loadMatchesData()
        } else {
            matchesTableView.isHidden = true
            standingsTableView.isHidden = false
            loadStandingsData()
        }
    }
    
    private func loadMatchesData() {
        
        guard let currentTournament = tournament else {
            return
        }
        
        let tournamentId = currentTournament.id
        
        Task {
            do {
                let events: [Event] = try await TournamentDataLoader.loadMatches(for: tournamentId)
                
                self.teamStreaks = TournamentHelper.calculateStreaks(from: events)
                let sortedSections = TournamentHelper.groupAndSortMatches(events)
                
                await MainActor.run {
                    matchesTableView.set(sections: sortedSections)
                }
            } catch {
                Alerts.showFetchError(on: self)
            }
        }
    }
    
    private func loadStandingsData() {
        
        guard let currentTournament = tournament else {
            return
        }
        
        let tournamentId = currentTournament.id
        
        Task {
            do {
                let standings: [Standings] = try await TournamentDataLoader.loadStandings(for: tournamentId)
                
                let processedRows = TournamentHelper.processStandings(standings, sport: currentSport, teamStreaks: teamStreaks)
                let singleSection = StandingSection(standings: processedRows)
                await MainActor.run {
                    standingsTableView.set(sections: [singleSection])
                }
            } catch {
                Alerts.showFetchError(on: self)
            }
        }
    }
    
    func set(tournament league: League, sport: Sport) {
        headerView.set(league: league)
        self.tournament = league
        self.currentSport = sport
        
        loadMatchesData()
    }
}
