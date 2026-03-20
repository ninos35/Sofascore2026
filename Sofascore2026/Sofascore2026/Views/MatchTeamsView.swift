//
//  MatchTeamsView.swift
//  Sofascore2026
//
//  Created by akademija on 19.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class MatchTeamsView: BaseView {
    
    private let homeTeamView = UIView()
    private let awayTeamView = UIView()
    
    private let homeLogoImageView = UIImageView()
    private let homeNameLabel = UILabel()
    private let awayLogoImageView = UIImageView()
    private let awayNameLabel = UILabel()

    override func addViews() {
        addSubview(homeTeamView)
        addSubview(awayTeamView)
        
        homeTeamView.addSubview(homeLogoImageView)
        homeTeamView.addSubview(homeNameLabel)
        
        awayTeamView.addSubview(awayLogoImageView)
        awayTeamView.addSubview(awayNameLabel)
    }

    override func styleViews() {
        homeNameLabel.textColor = Constants.Colors.black
        homeNameLabel.font = Constants.Fonts.regular
        
        awayNameLabel.textColor = Constants.Colors.black
        awayNameLabel.font = Constants.Fonts.regular
    }
    
    override func setupConstraints() {
        
        homeTeamView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(16)
        }
        awayTeamView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(30)
            make.trailing.equalToSuperview()
            make.height.equalTo(16)
        }
        
        homeLogoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.height.equalTo(16)
        }
        awayLogoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        homeNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(homeLogoImageView.snp.trailing).offset(6)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(16)
        }
        awayNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(awayLogoImageView.snp.trailing).offset(6)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(16)
        }
    }
    
    func set(event: Event){
        if event.status == .finished {
            if (event.homeScore ?? 0) < (event.awayScore ?? 0) {
                homeNameLabel.textColor = Constants.Colors.gray
            } else if (event.homeScore ?? 0) > (event.awayScore ?? 0) {
                awayNameLabel.textColor = Constants.Colors.gray
            }
        }
        homeLogoImageView.image = UIImage(named: event.homeTeam.name)
        awayLogoImageView.image = UIImage(named: event.awayTeam.name)
        
        homeNameLabel.text = event.homeTeam.name
        awayNameLabel.text = event.awayTeam.name
    }
}
