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
        
        homeScoreLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
        homeScoreLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        homeScoreLabel.textAlignment = .center
        
        awayScoreLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
        awayScoreLabel.font = UIFont(name: "Roboto-Regular", size: 14)
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
    
    func set(event: Event){
        homeScoreLabel.text = event.homeScore != nil ? "\(event.homeScore!)" : ""
        awayScoreLabel.text = event.awayScore != nil ? "\(event.awayScore!)" : ""

        switch event.status {
        case .notStarted:
            fallthrough
            
        case .inProgress:
            homeScoreLabel.textColor = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
            awayScoreLabel.textColor = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
            
        case .halftime:
            homeScoreLabel.textColor = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
            awayScoreLabel.textColor = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
            
        case .finished:
            if (event.homeScore ?? 0) > (event.awayScore ?? 0) {
                homeScoreLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            } else if (event.homeScore ?? 0) < (event.awayScore ?? 0) {
                awayScoreLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            }
        }
    }
}
