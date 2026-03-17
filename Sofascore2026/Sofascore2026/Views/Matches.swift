//
//  Matches.swift
//  Sofascore2026
//
//  Created by akademija on 15.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class Matches: BaseView {
        
    private let mainContainer = UIView()
    
    private let timeContainer = UIView()
    private let dateTimeLabel = UILabel()
    private let statusLabel = UILabel()
    
    private let divider = UIView()
    
    private let homeTeam = UIView()
    private let awayTeam = UIView()
    
    private let homeLogo = UIImageView()
    private let homeName = UILabel()
    private let awayLogo = UIImageView()
    private let awayName = UILabel()
    
    private let homeScore = UILabel()
    private let awayScore = UILabel()

    override func addViews() {
        // Add subviews to your custom view
        addSubview(mainContainer)
        
        mainContainer.addSubview(timeContainer)
        
        mainContainer.addSubview(homeTeam)
        mainContainer.addSubview(awayTeam)
        
        mainContainer.addSubview(divider)
        
        homeTeam.addSubview(homeLogo)
        homeTeam.addSubview(homeName)
        awayTeam.addSubview(awayLogo)
        awayTeam.addSubview(awayName)
        
        mainContainer.addSubview(homeScore)
        mainContainer.addSubview(awayScore)
        
        
        timeContainer.addSubview(dateTimeLabel)
        timeContainer.addSubview(statusLabel)
        
        
        
    }

    override func styleViews() {
        // Apply styles to your subviews
        
        dateTimeLabel.textColor = .lightGray
        dateTimeLabel.font = .systemFont(ofSize: 12)
        dateTimeLabel.textAlignment = .center
        
        statusLabel.textColor = .lightGray
        statusLabel.font = .systemFont(ofSize: 12)
        statusLabel.textAlignment = .center
        
        divider.backgroundColor = .lightGray
        
        homeName.textColor = .black
        homeName.font = .systemFont(ofSize: 14)
        homeName.textAlignment = .right
        
        awayName.textColor = .black
        awayName.font = .systemFont(ofSize: 14)
        awayName.textAlignment = .right
        
        homeScore.textColor = .lightGray
        homeScore.font = .systemFont(ofSize: 14)
        homeScore.textAlignment = .right
        
        awayScore.textColor = .lightGray
        awayScore.font = .systemFont(ofSize: 14)
        awayScore.textAlignment = .right
            
    }

    override func setupConstraints() {
        // Set up Layout constraints
        mainContainer.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        timeContainer.snp.makeConstraints { make in
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
        
        divider.snp.makeConstraints { make in
            make.leading.equalTo(timeContainer.snp.trailing).offset(-1)
            make.height.equalTo(40)
            make.width.equalTo(1)
            make.centerY.equalToSuperview()
        }
        
        homeTeam.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(10)
        }
        awayTeam.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.top.equalToSuperview().offset(30)
        }
        
        homeLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.height.equalTo(16)
        }
        awayLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        homeName.snp.makeConstraints { make in
            make.leading.equalTo(homeLogo.snp.trailing).offset(6)
            make.height.equalTo(16)
        }
        awayName.snp.makeConstraints { make in
            make.leading.equalTo(awayLogo.snp.trailing).offset(6)
            make.height.equalTo(16)
        }
        
        
        
        homeScore.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(10)
        }
        awayScore.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(30)
        }
        
    }

    override func setupGestureRecognizers() {
        // Configure gesture recognizers
    }

    override func setupBinding() {
        // Set up bindings
    }
    
    func set(event: Event){
        
        let date = Date(timeIntervalSince1970: Double(event.startTimestamp))

        switch event.status {
        case .notStarted:
            statusLabel.text = String(event.startTimestamp)
            statusLabel.text = "-"

            
        case .inProgress:
            homeScore.textColor = .red
            awayScore.textColor = .red
            statusLabel.textColor = .red
            statusLabel.text = String(Int(Date().timeIntervalSince(date)/60)) + "'"
            
        case .halftime:
            homeScore.textColor = .lightGray
            homeName.textColor = .lightGray
            

        case .finished:
            statusLabel.text = "FT"

            if (event.homeScore ?? 0) > (event.awayScore ?? 0) {
                homeScore.textColor = .black
                homeName.textColor = .black
            } else if (event.homeScore ?? 0) < (event.awayScore ?? 0) {
                awayScore.textColor = .black
                awayName.textColor = .black
            }
        }
        
        if (event.homeScore ?? 0) > (event.awayScore ?? 0) {
            homeScore.textColor = .black
        } else if (event.homeScore ?? 0) < (event.awayScore ?? 0) {
            awayScore.textColor = .black
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        dateTimeLabel.text = String(formatter.string(from: date))

        
        homeLogo.image = UIImage(named: event.homeTeam.name)
        awayLogo.image = UIImage(named: event.awayTeam.name)
        
        homeName.text = event.homeTeam.name
        awayName.text = event.awayTeam.name
        
        homeScore.text = event.homeScore != nil ? "\(event.homeScore!)" : ""
        awayScore.text = event.awayScore != nil ? "\(event.awayScore!)" : ""
        
        
        

    }
}
