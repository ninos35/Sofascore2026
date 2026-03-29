//
//  DetailedTeamView.swift
//  Sofascore2026
//
//  Created by akademija on 29.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class DetailedTeamView: BaseView {
    
    let teamLogoImageView = UIImageView()
    let teamNameLabel = UILabel()
    
    override func addViews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
    }
    
    override func styleViews() {
        teamNameLabel.textAlignment = .center
        teamNameLabel.numberOfLines = 2
        teamNameLabel.font = Constants.Fonts.bold
    }
    
    override func setupConstraints() {
        
        teamLogoImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        teamNameLabel.snp.makeConstraints { make in
            make.top.equalTo(teamLogoImageView.snp.bottom).offset(8)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func set(team: Team) {
        teamLogoImageView.image = UIImage(named: team.name)
        teamNameLabel.text = team.name
    }
}
