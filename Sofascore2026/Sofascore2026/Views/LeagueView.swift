//
//  League.swift
//  Sofascore2026
//
//  Created by akademija on 17.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class LeagueView: BaseView {
    
    private let mainContainer = UIView()
    private let logoImageView = UIImageView()
    
    private let textImageView = UIStackView()
    
    private let countryLabel = UILabel()
    private let arrow = UIImageView()
    private let leagueLabel = UILabel()
    
    override func addViews() {
        addSubview(mainContainer)
        mainContainer.addSubview(logoImageView)
        mainContainer.addSubview(textImageView)
        
        textImageView.addArrangedSubview(countryLabel)
        textImageView.addArrangedSubview(arrow)
        textImageView.addArrangedSubview(leagueLabel)
    }

    override func styleViews() {
        mainContainer.backgroundColor = .white
        
        countryLabel.font = UIFont(name: "Roboto-Bold", size: 14)
        arrow.image = UIImage(named: "Vector")
        arrow.contentMode = .scaleAspectFit
        leagueLabel.textColor = .gray
        leagueLabel.font = UIFont(name: "Roboto-Regular", size: 14)

        
        textImageView.spacing = 10
        }

    override func setupConstraints() {
        
        mainContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        textImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
        arrow.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(5)
        }
    }

    func set(league: League){
        countryLabel.text = league.country?.name
        leagueLabel.text = league.name
        logoImageView.image = UIImage(named: league.name)
    }
}
