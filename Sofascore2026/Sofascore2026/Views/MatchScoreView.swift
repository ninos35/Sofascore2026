//
//  MatchScoreView.swift
//  Sofascore2026
//
//  Created by akademija on 19.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class MatchScoreView: BaseView {
    
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    
    override func addViews() {
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
    }
    
    override func styleViews() {
        
        homeScoreLabel.textColor = Constants.Colors.gray
        homeScoreLabel.font = Constants.Fonts.regular
        homeScoreLabel.textAlignment = .center
        
        awayScoreLabel.textColor = Constants.Colors.gray
        awayScoreLabel.font = Constants.Fonts.regular
        awayScoreLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        homeScoreLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(16)
        }
        awayScoreLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(30)
            make.width.equalTo(16)
        }
    }
    
    func set(event: Event) {
        homeScoreLabel.text = event.homeScore != nil ? "\(event.homeScore!)" : ""
        awayScoreLabel.text = event.awayScore != nil ? "\(event.awayScore!)" : ""
        
        homeScoreLabel.textColor = Constants.Colors.gray
        awayScoreLabel.textColor = Constants.Colors.gray
        
        switch event.status {
        case .notStarted:
            break
            
        case .inProgress:
            homeScoreLabel.textColor = Constants.Colors.red
            awayScoreLabel.textColor = Constants.Colors.red
            
        case .halftime:
            homeScoreLabel.textColor = Constants.Colors.red
            awayScoreLabel.textColor = Constants.Colors.red
            
        case .finished:
            if (event.homeScore ?? 0) > (event.awayScore ?? 0) {
                homeScoreLabel.textColor = Constants.Colors.black
            } else if (event.homeScore ?? 0) < (event.awayScore ?? 0) {
                awayScoreLabel.textColor = Constants.Colors.black
            }
        }
    }
}
