//
//  LeagueCell.swift
//  Sofascore2026
//
//  Created by akademija on 22.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class LeagueCell: UITableViewHeaderFooterView {
    
    static let id: String = "LeagueCell"
    
    private let leagueView: LeagueView = LeagueView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func set() {
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        contentView.addSubview(leagueView)
    }
    
    func setupConstraints() {
        leagueView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with league: League) {
        leagueView.set(league: league)
    }
}
