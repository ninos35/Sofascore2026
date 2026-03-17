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
    private let logoContainer = UIImageView()
    
    private let textContainter = UIStackView()
    
    private let countryLabel = UILabel()
    private let arrow = UIImageView()
    private let leagueLabel = UILabel()
    

    override func addViews() {
        // Add subviews to your custom view
        addSubview(mainContainer)
        mainContainer.addSubview(logoContainer)
        mainContainer.addSubview(textContainter)
        
        textContainter.addArrangedSubview(countryLabel)
        textContainter.addArrangedSubview(arrow)
        textContainter.addArrangedSubview(leagueLabel)
    }

    override func styleViews() {
        // Apply styles to your subviews
        mainContainer.backgroundColor = .white
        
        countryLabel.font = .boldSystemFont(ofSize: 14)
        arrow.image = UIImage(named: "Vector")
        arrow.contentMode = .scaleAspectFit
        leagueLabel.textColor = .gray
        leagueLabel.font = .boldSystemFont(ofSize: 14)
        
    }

    override func setupConstraints() {
        // Set up Layout constraints
        mainContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(56)
        }
        logoContainer.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        textContainter.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
        arrow.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(5)
        }
    
        textContainter.spacing = 10

    }

    override func setupGestureRecognizers() {
        // Configure gesture recognizers
    }

    override func setupBinding() {
        // Set up bindings
    }
    
    func set(league: League){
        countryLabel.text = league.country?.name
        leagueLabel.text = league.name
        logoContainer.image = UIImage(named: league.name)
    }
}
