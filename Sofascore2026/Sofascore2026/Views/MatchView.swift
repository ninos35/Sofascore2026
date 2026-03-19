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
    
    private let timeView = UIView()
    private let dateTimeLabel = UILabel()
    private let statusLabel = UILabel()
    
    private let dividerView = UIView()
    
    private let homeTeamView = UIView()
    private let awayTeamView = UIView()
    
    private let homeLogoImageView = UIImageView()
    private let homeNameLabel = UILabel()
    private let awayLogoImageView = UIImageView()
    private let awayNameLabel = UILabel()
    
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()

    override func addViews() {
        
        addSubview(mainView)
        
        mainView.addSubview(timeView)
        
        mainView.addSubview(homeTeamView)
        mainView.addSubview(awayTeamView)
        
        mainView.addSubview(dividerView)
        
        homeTeamView.addSubview(homeLogoImageView)
        homeTeamView.addSubview(homeNameLabel)
        awayTeamView.addSubview(awayLogoImageView)
        awayTeamView.addSubview(awayNameLabel)
        
        mainView.addSubview(homeScoreLabel)
        mainView.addSubview(awayScoreLabel)
        
        
        timeView.addSubview(dateTimeLabel)
        timeView.addSubview(statusLabel)
    }

    override func styleViews() {
        
        dateTimeLabel.textColor = .lightGray
        dateTimeLabel.font = UIFont(name: "RobotoCondensed-Regular", size: 12)
        dateTimeLabel.textAlignment = .center
        
        statusLabel.textColor = .lightGray
        statusLabel.font = UIFont(name: "RobotoCondensed-Regular", size: 12)
        statusLabel.textAlignment = .center
        
        dividerView.backgroundColor = .lightGray
        
        homeNameLabel.textColor = .black
        homeNameLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        
        awayNameLabel.textColor = .black
        awayNameLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        
        homeScoreLabel.textColor = .lightGray
        homeScoreLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        homeScoreLabel.textAlignment = .center
        
        awayScoreLabel.textColor = .lightGray
        awayScoreLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        awayScoreLabel.textAlignment = .center

    }

    override func setupConstraints() {
        
        mainView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        timeView.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        dateTimeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(4)
            make.top.equalToSuperview().offset(10)
        }
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(4)
            make.top.equalToSuperview().offset(30)
        }
        
        dividerView.snp.makeConstraints { make in
            make.leading.equalTo(timeView.snp.trailing).offset(-1)
            make.height.equalTo(40)
            make.width.equalTo(1)
            make.centerY.equalToSuperview()
        }
        
        homeTeamView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(10)
        }
        awayTeamView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(30)
        }
        
        homeLogoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.height.equalTo(16)
        }
        awayLogoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        homeNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(homeLogoImageView.snp.trailing).offset(6)
            make.height.equalTo(16)
        }
        awayNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(awayLogoImageView.snp.trailing).offset(6)
            make.height.equalTo(16)
        }
            
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
        
        let date: Date = Date(timeIntervalSince1970: Double(event.startTimestamp))
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        switch event.status {
        case .notStarted:
            statusLabel.text = String(event.startTimestamp)
            statusLabel.text = "-"

        case .inProgress:
            homeScoreLabel.textColor = .red
            awayScoreLabel.textColor = .red
            statusLabel.textColor = .red
            statusLabel.text = String(Int(Date().timeIntervalSince(date)/60)) + "'"
            
        case .halftime:
            homeScoreLabel.textColor = .lightGray
            homeNameLabel.textColor = .lightGray
            
        case .finished:
            statusLabel.text = "FT"
            if (event.homeScore ?? 0) < (event.awayScore ?? 0) {
                homeScoreLabel.textColor = .lightGray
                homeNameLabel.textColor = .lightGray
            } else if (event.homeScore ?? 0) > (event.awayScore ?? 0) {
                awayScoreLabel.textColor = .lightGray
                awayNameLabel.textColor = .lightGray
            }
        }
        
        if (event.homeScore ?? 0) > (event.awayScore ?? 0) {
            homeScoreLabel.textColor = .black
        } else if (event.homeScore ?? 0) < (event.awayScore ?? 0) {
            awayScoreLabel.textColor = .black
        }
        
        dateTimeLabel.text = String(formatter.string(from: date))
        
        homeLogoImageView.image = UIImage(named: event.homeTeam.name)
        awayLogoImageView.image = UIImage(named: event.awayTeam.name)
        
        homeNameLabel.text = event.homeTeam.name
        awayNameLabel.text = event.awayTeam.name
        
        homeScoreLabel.text = event.homeScore != nil ? "\(event.homeScore!)" : ""
        awayScoreLabel.text = event.awayScore != nil ? "\(event.awayScore!)" : ""
    }
}
