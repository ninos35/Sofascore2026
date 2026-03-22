//
//  EventTableView.swift
//  Sofascore2026
//
//  Created by akademija on 20.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

struct Section {
    let league: League
    let events: [Event]
}

class EventTableView: BaseView {
    
    private var sections: [Section] = []
    
    private let tableView = UITableView()
    
    override func addViews() {
        addSubview(tableView)
    }
    
    override func styleViews() {
        tableView.register(LeagueCell.self, forHeaderFooterViewReuseIdentifier: LeagueCell.id)
        tableView.register(MatchCell.self, forCellReuseIdentifier: MatchCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(sections: [Section]){
        self.sections = sections
        tableView.reloadData()
    }
}

extension EventTableView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].events.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LeagueCell.id) as? LeagueCell else {
            return nil
        }
        let leagueData = sections[section].league
        header.configure(with: leagueData)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchCell.id, for: indexPath) as? MatchCell else {
            return UITableViewCell()
        }
        let match = sections[indexPath.section].events[indexPath.row]
        cell.configure(with: match)
        return cell
    }
}
