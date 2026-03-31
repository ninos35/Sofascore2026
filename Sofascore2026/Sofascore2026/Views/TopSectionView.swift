//
//  Frame.swift
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
    
    private let settingsImageView = UIImageView()
    
    var settingsClicked: (() -> Void)?
    
    override func addViews() {
        addSubview(headerView)
        addSubview(sportsStackView)
        
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
        settingsImageView.image = UIImage(named: Constants.Icons.settingsIcon)
        settingsImageView.contentMode = .scaleAspectFit
        
        settingsImageView.isUserInteractionEnabled = true
    }
    
    override func setupGestureRecognizers() {
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
