
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
        Task {
            do {
                let events: [Event] = try await APIClient.shared.getTournamentMatches(id: tournament!.id)
                await MainActor.run {
                    setTournamentTableViewData(data: events)
                }
            } catch {
                Alerts.showFetchError(on: self)
            }
        }
    }
    
    private func loadStandingsData() {
        Task {
            do {
                let standings: [Standings] = try await APIClient.shared.getTournamentStandings(id: tournament!.id)
                await MainActor.run {
                    setTournamentStandings(standings: standings)
                }
            } catch {
                Alerts.showFetchError(on: self)
            }
        }
    }
    
    private func setTournamentTableViewData(data: [Event]) {
        teamStreaks = calculateStreaks(from: data)
        
        let groupedByRound = Dictionary(grouping: data) { Int($0.round!) }
        
        let finalSections: [Section] = groupedByRound.map { (roundNumber, events) in
            return Section(header: .round(Int32(roundNumber)), events: events)
        }
        
        let sortedSections = finalSections.sorted { (section1: Section, section2: Section) in
            if case .round(let num1) = section1.header,
               case .round(let num2) = section2.header {
                
                return num1 < num2
            }
            return false
        }
        
        matchesTableView.set(sections: sortedSections)
    }
    
    private func setTournamentStandings(standings: [Standings]) {
        var sortedRows: [Standings] = standings.sorted { $0.position < $1.position }
        
        if currentSport == .basketball {
            let leader: Standings? = sortedRows.first
            
            sortedRows = sortedRows.map { s in
                var updated = s
                if let leader = leader {
                    updated.gb = Double((leader.wins - s.wins) + (s.losses - leader.losses)) / 2.0
                }
                updated.str = teamStreaks[Int(s.team.id)]
                return updated
            }
        }
        
        let singleSection: StandingSection = StandingSection(standings: sortedRows)
        standingsTableView.set(sections: [singleSection])
    }
    
    private func calculateStreaks(from events: [Event]) -> [Int: String] {
        var teamEvents: [Int: [Event]] = [:]
        
        for event in events {
            teamEvents[Int(event.homeTeam.id), default: []].append(event)
            teamEvents[Int(event.awayTeam.id), default: []].append(event)
        }
        
        var streaks: [Int: String] = [:]
        
        for (teamId, matches) in teamEvents {
            let sorted: [Event] = matches.sorted { $0.startTimestamp > $1.startTimestamp }
            
            var count: Int = 0
            var lastResult: String? = nil
            
            for match in sorted {
                guard let homeScore = match.homeScore,
                      let awayScore = match.awayScore else { continue }
                
                let isHome = match.homeTeam.id == teamId
                let result: String
                
                if homeScore == awayScore {
                    result = "D"
                } else if (isHome && homeScore > awayScore) || (!isHome && awayScore > homeScore) {
                    result = "W"
                } else {
                    result = "L"
                }
                
                if lastResult == nil { lastResult = result }
                if result == lastResult {
                    count += 1
                } else {
                    break
                }
            }
            
            if let last = lastResult {
                streaks[teamId] = "\(last)\(count)"
            }
        }
        
        return streaks
    }
    
    func set(tournament league: League, sport: Sport) {
        headerView.set(league: league)
        self.tournament = league
        self.currentSport = sport
        
        loadMatchesData()
    }
}
