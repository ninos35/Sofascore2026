//
//  DetailedMatchDataView.swift
//  Sofascore2026
//
//  Created by akademija on 29.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class DetailedMatchDataView: BaseView {
    
    let startDateLabel = UILabel()
    let startTimeLabel = UILabel()
    
    let matchScoreView = UIView()
    
    let homeScoreLabel = UILabel()
    let awayScoreLabel = UILabel()
    let dashLabel = UILabel()
    
    let matchTimeLabel = UILabel()
    
    override func addViews() {
        addSubview(startDateLabel)
        addSubview(startTimeLabel)
        
        addSubview(matchScoreView)
        addSubview(matchTimeLabel)
        
        matchScoreView.addSubview(homeScoreLabel)
        matchScoreView.addSubview(awayScoreLabel)
        matchScoreView.addSubview(dashLabel)
    }
    
    override func styleViews() {
        startDateLabel.textColor = Constants.Colors.black
        startDateLabel.textAlignment = .center
        startDateLabel.font = Constants.Fonts.regularCondensed
        
        startTimeLabel.textColor = Constants.Colors.black
        startTimeLabel.textAlignment = .center
        startTimeLabel.font = Constants.Fonts.regularCondensed
        
        homeScoreLabel.textColor = Constants.Colors.gray
        homeScoreLabel.textAlignment = .right
        homeScoreLabel.font = Constants.Fonts.bigBold
        
        awayScoreLabel.textColor = Constants.Colors.gray
        awayScoreLabel.textAlignment = .left
        awayScoreLabel.font = Constants.Fonts.bigBold
        
        dashLabel.text = "-"
        dashLabel.textColor = Constants.Colors.gray
        dashLabel.textAlignment = .center
        dashLabel.font = Constants.Fonts.bigBold
        
        matchTimeLabel.textAlignment = .center
        matchTimeLabel.font = Constants.Fonts.regularCondensed
    }
    
    override func setupConstraints() {
        startDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.width.equalTo(136)
            make.centerX.equalToSuperview()
        }
        
        startTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.width.equalTo(136)
            make.centerX.equalToSuperview()
        }
        
        matchScoreView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(136)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        homeScoreLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(56)
            make.leading.equalToSuperview()
        }
        awayScoreLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(56)
            make.trailing.equalToSuperview()
        }
        dashLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(homeScoreLabel.snp.trailing)
            make.trailing.equalTo(awayScoreLabel.snp.leading)
        }
        
        matchTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.width.equalTo(136)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func set(match: Event) {
        
        let date: Date = Date(timeIntervalSince1970: Double(match.startTimestamp))
        let formatter: DateFormatter = DateFormatter()
        
        homeScoreLabel.text = match.homeScore != nil ? "\(match.homeScore!)" : ""
        awayScoreLabel.text = match.awayScore != nil ? "\(match.awayScore!)" : ""
        
        switch match.status {
        case .notStarted:
            matchScoreView.isHidden = true
            
            formatter.dateFormat = "dd.MM.yyyy."
            startDateLabel.text = formatter.string(from: date)
            
            formatter.dateFormat = "HH:mm"
            startTimeLabel.text = formatter.string(from: date)
            
        case .inProgress:
            startDateLabel.isHidden = true
            startTimeLabel.isHidden = true
            
            homeScoreLabel.textColor = Constants.Colors.red
            awayScoreLabel.textColor = Constants.Colors.red
            dashLabel.textColor = Constants.Colors.red
            
            matchTimeLabel.text = String(Int(Date().timeIntervalSince(date)/60)) + "'"
            matchTimeLabel.textColor = Constants.Colors.red
            
        case .halftime:
            startDateLabel.isHidden = true
            startTimeLabel.isHidden = true
            
            homeScoreLabel.textColor = Constants.Colors.red
            awayScoreLabel.textColor = Constants.Colors.red
            dashLabel.textColor = Constants.Colors.red
            
            matchTimeLabel.text = "HT"
            matchTimeLabel.textColor = Constants.Colors.red
            
            
        case .finished:
            startDateLabel.isHidden = true
            startTimeLabel.isHidden = true
            
            if (match.homeScore ?? 0) > (match.awayScore ?? 0) {
                homeScoreLabel.textColor = Constants.Colors.black
            } else if (match.homeScore ?? 0) < (match.awayScore ?? 0) {
                awayScoreLabel.textColor = Constants.Colors.black
            }
            
            matchTimeLabel.text = "Full Time"
            matchTimeLabel.textColor = Constants.Colors.gray
        }
    }
}
