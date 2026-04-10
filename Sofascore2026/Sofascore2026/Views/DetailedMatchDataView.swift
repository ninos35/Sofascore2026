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
    
    let startDataStackView: UIStackView = UIStackView()
    let startDateLabel: UILabel = UILabel()
    let startTimeLabel: UILabel = UILabel()
    
    let matchDetailsStackView: UIStackView = UIStackView()
    
    let matchScoreStackView: UIStackView = UIStackView()
    let homeScoreLabel: UILabel = UILabel()
    let awayScoreLabel: UILabel = UILabel()
    let dashLabel: UILabel = UILabel()
    
    let matchTimeLabel: UILabel = UILabel()
    
    override func addViews() {
        addSubview(startDataStackView)
        addSubview(matchDetailsStackView)
        
        matchDetailsStackView.addArrangedSubview(matchScoreStackView)
        matchDetailsStackView.addArrangedSubview(matchTimeLabel)
        
        startDataStackView.addArrangedSubview(startDateLabel)
        startDataStackView.addArrangedSubview(startTimeLabel)
        
        matchScoreStackView.addArrangedSubview(homeScoreLabel)
        matchScoreStackView.addArrangedSubview(dashLabel)
        matchScoreStackView.addArrangedSubview(awayScoreLabel)
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
        
        matchDetailsStackView.axis = .vertical
        
        startDataStackView.axis = .vertical
        
        matchScoreStackView.axis = .horizontal
    }
    
    override func setupConstraints() {
        startDataStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(136)
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
        }
        startDateLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        startTimeLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        
        matchDetailsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(136)
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
        }
        matchScoreStackView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        homeScoreLabel.snp.makeConstraints { make in
            make.width.equalTo(56)
        }
        awayScoreLabel.snp.makeConstraints { make in
            make.width.equalTo(56)
        }
        dashLabel.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
        matchTimeLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
    }
    
    func set(match: Event) {
        
        let date: Date = Date(timeIntervalSince1970: Double(match.startTimestamp))
        
        homeScoreLabel.text = match.homeScore?.toString() ?? ""
        awayScoreLabel.text = match.awayScore?.toString() ?? ""
        
        startDataStackView.isHidden = false
        matchDetailsStackView.isHidden = false
        
        switch match.status {
        case .notStarted:
            matchDetailsStackView.isHidden = true
            
            startDateLabel.text = MatchHelper.formatDate(date: date)
            startTimeLabel.text = MatchHelper.formatTime(date: date)
            
        case .inProgress:
            startDataStackView.isHidden = true
            
            homeScoreLabel.textColor = Constants.Colors.red
            awayScoreLabel.textColor = Constants.Colors.red
            dashLabel.textColor = Constants.Colors.red
            
            matchTimeLabel.text = String(Int(Date().timeIntervalSince(date)/60)) + "'"
            matchTimeLabel.textColor = Constants.Colors.red
            
        case .halftime:
            startDataStackView.isHidden = true

            homeScoreLabel.textColor = Constants.Colors.red
            awayScoreLabel.textColor = Constants.Colors.red
            dashLabel.textColor = Constants.Colors.red
            
            matchTimeLabel.text = "HT"
            matchTimeLabel.textColor = Constants.Colors.red
            
            
        case .finished:
            startDataStackView.isHidden = true

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
