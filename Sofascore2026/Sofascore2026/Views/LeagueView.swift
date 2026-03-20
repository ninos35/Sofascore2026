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
    
    private let mainView = UIView()
    private let logoImageView = UIImageView()
    
    private let leagueStackView = UIStackView()
    
    private let countryLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let leagueLabel = UILabel()
    
    override func addViews() {
        addSubview(mainView)
        mainView.addSubview(logoImageView)
        mainView.addSubview(leagueStackView)
        
        leagueStackView.addArrangedSubview(countryLabel)
        leagueStackView.addArrangedSubview(arrowImageView)
        leagueStackView.addArrangedSubview(leagueLabel)
    }

    override func styleViews() {
        mainView.backgroundColor = .white
        
        countryLabel.font = Constants.Fonts.bold
        countryLabel.textColor = Constants.Colors.black
        
        arrowImageView.image = UIImage(named: "Vector")
        arrowImageView.contentMode = .scaleAspectFit

        leagueLabel.font = Constants.Fonts.bold
        leagueLabel.textColor = Constants.Colors.gray
        
        leagueStackView.spacing = 7
        }

    override func setupConstraints() {
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        leagueStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
    }

    func set(league: League){
        countryLabel.text = league.country?.name
        leagueLabel.text = league.name
        logoImageView.image = UIImage(named: league.name)
    }
}
