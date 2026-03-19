//
//  Matches.swift
//  Sofascore2026
//
//  Created by akademija on 15.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class MatchView: BaseView {
        
    private let mainView = UIView()
    
    private let matchStatusView = MatchStatusView()
    private let matchTeamsView = MatchTeamsView()
    private let matchScoreView = MatchScoreView()

    override func addViews() {
        
        addSubview(mainView)
        
        mainView.addSubview(matchStatusView)
        mainView.addSubview(matchTeamsView)
        mainView.addSubview(matchScoreView)
    }

    override func styleViews() {
    }

    override func setupConstraints() {
        
        mainView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        matchStatusView.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        matchScoreView.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    func set(event: Event){
        matchStatusView.set(event: event)
        matchTeamsView.set(event: event)
        matchScoreView.set(event: event)
    }
}
