//
//  SettingsView.swift
//  Sofascore2026
//
//  Created by akademija on 25.05.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class SettingsView: BaseView {
    
    private let titleLabel: UILabel = UILabel()
    
    private let usernameLabel: UILabel = UILabel()
    private let leaguesLabel: UILabel = UILabel()
    private let eventsLabel: UILabel = UILabel()
    
    let dismissLabel: UILabel = UILabel()
    let logoutLabel: UILabel = UILabel()
    
    override func addViews() {
        addSubview(titleLabel)
        
        addSubview(usernameLabel)
        addSubview(leaguesLabel)
        addSubview(eventsLabel)
        
        addSubview(dismissLabel)
        addSubview(logoutLabel)
    }
    
    override func styleViews() {
        
        titleLabel.text = "Settings"
        titleLabel.font = Constants.Fonts.bold
        titleLabel.textAlignment = .center
        
        usernameLabel.text = "Username: " + (UserDefaults.standard.string(forKey: "username") ?? "No username")
        usernameLabel.font = Constants.Fonts.regular
        usernameLabel.textAlignment = .center
        
        leaguesLabel.text = "No. of leagues: \((try? DatabaseManager.shared.leagueCount()) ?? 0)"
        leaguesLabel.font = Constants.Fonts.regular
        leaguesLabel.textAlignment = .center
        
        eventsLabel.text = "No. of events: \((try? DatabaseManager.shared.eventCount()) ?? 0)"
        eventsLabel.font = Constants.Fonts.regular
        eventsLabel.textAlignment = .center
        
        dismissLabel.text = "Dismiss"
        dismissLabel.textColor = Constants.Colors.lightBlue
        dismissLabel.font = Constants.Fonts.regular
        dismissLabel.textAlignment = .center
        
        logoutLabel.text = "Logout"
        logoutLabel.textColor = Constants.Colors.red
        logoutLabel.font = Constants.Fonts.regular
        logoutLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        leaguesLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        eventsLabel.snp.makeConstraints { make in
            make.top.equalTo(leaguesLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        logoutLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        dismissLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoutLabel.snp.bottom).offset(24)
        }
    }
}
