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
    
    private let sportsStackView = UIStackView()
    
    override func addViews() {
        addSubview(sportsStackView)
    }
    
    override func styleViews() {
        sportsStackView.backgroundColor = Constants.Colors.lightBlue
        sportsStackView.axis = .horizontal
        sportsStackView.distribution = .fillEqually
    }
    
    override func setupConstraints() {
        sportsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
            sportView.set(sport:(name:sport.name,icon:sport.icon))
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
