//
//  TopSectionView.swift
//  Sofascore2026
//
//  Created by akademija on 14.03.2026..
//
import SofaAcademic
import UIKit
import SnapKit

class TopSectionView: BaseView {
    
    private let headerView = UIView()
    private let sportsStackView = UIStackView()
    
    private let logoImageView = UIImageView()
    private let trophyImageView = UIImageView()
    private let settingsImageView = UIImageView()
    
    var settingsClicked: (() -> Void)?
    var changeSportData: ((Constants.Sports) -> Void)?
    
    override func addViews() {
        addSubview(headerView)
        addSubview(sportsStackView)
        
        headerView.addSubview(logoImageView)
        headerView.addSubview(trophyImageView)
        headerView.addSubview(settingsImageView)
        
        setupSettings()
    }
    
    override func styleViews() {
        sportsStackView.backgroundColor = Constants.Colors.lightBlue
        sportsStackView.axis = .horizontal
        sportsStackView.distribution = .fillEqually
    }
    
    override func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(132)
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        trophyImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().offset(-52)
            make.centerY.equalToSuperview()
        }
        settingsImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        sportsStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupSettings() {
        logoImageView.image = UIImage(named: Constants.Icons.logoIcon)
        
        trophyImageView.image = UIImage(named: Constants.Icons.trophyIcon)
        
        settingsImageView.image = UIImage(named: Constants.Icons.settingsIcon)
    }
    
    override func setupGestureRecognizers() {
        settingsImageView.isUserInteractionEnabled = true
        
        let settingsTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedSettings))
        settingsImageView.addGestureRecognizer(settingsTapGesture)
    }
    
    @objc private func clickedSettings() {
        settingsClicked?()
    }
    
    func changeSport(clicked: SportView) {
        for subview in sportsStackView.arrangedSubviews {
            if let otherSportView = subview as? SportView,
               otherSportView != clicked {
                otherSportView.isSelected = false
            }
            else {
                guard let sport = clicked.sport else { return }
                self.changeSportData?(sport)
            }
        }
    }
    
    func set(sports: [Constants.Sports]) {
        
        for (index,sport) in sports.enumerated() {
            let sportView = SportView()
            sportView.set(sport: sport)
            if  index == 0 {
                sportView.isSelected = true
            }
            sportsStackView.addArrangedSubview(sportView)
            
            sportView.stateChanged = { [weak self] clickedSport in
                if clickedSport.isSelected{
                    self?.changeSport(clicked: clickedSport)
                }
            }
        }
    }
}
