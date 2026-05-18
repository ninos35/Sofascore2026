//
//  ViewController.swift
//  Sofascore2026
//
//  Created by akademija on 05.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
    
    private let APIDataSource: APIClient = APIClient()
    
    private let sports: [Sport] = [.football,.basketball,.americanFootball]
    
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
        //        Task {
        //            do {
        //                let events = try await APIDataSource.getAllEvents(sport: sport.urlKey)
        //                await MainActor.run {
        //                    setTableViewData(data: events)
        //                }
        //            }
        //        }
        APIDataSource.getAllEventsOld(sport: sport.urlKey) { [weak self] events in
            DispatchQueue.main.async {
                guard let self = self else {return}
                
                if let fetched = events {
                    self.setTableViewData(data: fetched)
                }
            }
        }
    }
    
    func setTableViewData(data: [Event]) {
        
        let grouped = Dictionary(grouping: data) { $0.league.id }
        
        let finalSections: [Section] = grouped.compactMap { (key, events) in
            guard let firstLeague = events.first?.league else {
                return nil
            }
            return Section(league: firstLeague, events: events)
        }
        
        let sortedSections = finalSections.sorted { $0.league.id < $1.league.id }
        
        tableView.set(sections: sortedSections)
    }
    
    func gestureRecognisers() {
        topSectionView.settingsClicked = { [weak self] in
            let settingsViewController = SettingsViewController()
            settingsViewController.modalPresentationStyle = .fullScreen
            self?.present(settingsViewController,animated: true)
        }
        
        tableView.selectedEvent = { [weak self] selectedMatch in
            let eventDetailsViewController = EventDetailsViewController()
            eventDetailsViewController.setEventDetails(match: selectedMatch)
            
            self?.navigationController?.pushViewController(eventDetailsViewController, animated: true)
        }
        
        topSectionView.changeSportData = { [weak self] selectedSport in
            self?.loadData(for: selectedSport)
        }
    }
}
