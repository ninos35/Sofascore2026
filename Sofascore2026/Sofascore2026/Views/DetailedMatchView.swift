//
//  DetailedMatchView.swift
//  Sofascore2026
//
//  Created by akademija on 29.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class DetailedMatchView: BaseView {
    
    private let eventView: UIView = UIView()
    
    private let homeDetailedTeamView: DetailedTeamView = DetailedTeamView()
    private let detailedMatchDataView: DetailedMatchDataView = DetailedMatchDataView()
    private let awayDetailedTeamView: DetailedTeamView = DetailedTeamView()
    
    
    override func addViews() {
        addSubview(eventView)
        
        eventView.addSubview(homeDetailedTeamView)
        eventView.addSubview(detailedMatchDataView)
        eventView.addSubview(awayDetailedTeamView)
    }
    
    override func setupConstraints() {
        eventView.snp.makeConstraints { make in
            make.height.equalTo(112)
            make.top.leading.trailing.equalToSuperview()
        }
        
        homeDetailedTeamView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(96)
            make.height.equalTo(80)
        }
        
        detailedMatchDataView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(136)
            make.height.equalTo(112)
            make.centerX.equalToSuperview()
        }
        
        awayDetailedTeamView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(96)
            make.height.equalTo(80)
        }
    }
    
    func set(detailedMatch: Event) {
        homeDetailedTeamView.set(team: detailedMatch.homeTeam)
        detailedMatchDataView.set(match: detailedMatch)
        awayDetailedTeamView.set(team: detailedMatch.awayTeam)
    }
}
