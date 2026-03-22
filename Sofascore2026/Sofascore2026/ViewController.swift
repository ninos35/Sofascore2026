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
    
    private let dataSource = Homework3DataSource()
    private let sports: [(String,String)] = [
        ("Football","icon_football"),
        ("Basketball","icon_basketball"),
        ("Am. Football","icon_american_football")
    ]
    
    private let frame = Frame()
    
    private let tableView = EventTableView()
    
    private let leagueView = LeagueView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        
        frame.set(sports:sports)
        
        tableViewSetup(data: dataSource.events())
    }
    
    func addViews(){
        view.addSubview(frame)
        view.addSubview(tableView)
    }
    
    func styleViews(){
        view.backgroundColor = .white
    }
    
    func setupConstraints(){
        
        frame.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(frame.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(624)
        }
    }
    
    func tableViewSetup(data: [Event]) {
        
        let grouped = Dictionary(grouping: data) { $0.league?.id ?? 0 }
        
        let finalSections: [Section] = grouped.compactMap { (key, events) in
            guard let firstLeague = events.first?.league else {
                return nil
            }
            return Section(league: firstLeague, events: events)
        }
        
        let sortedSections = finalSections.sorted { $0.league.id < $1.league.id }
        
        tableView.set(sections: sortedSections)
    }
}
