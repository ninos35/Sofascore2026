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
    
    private let day: String
    let events: [(League, [Event])]
    
    init (day: String, events: [(League,[Event])]) {
        self.day = day
        self.events = events
        super.init()
    }
    
    private let listSection = UIView()
    
    private let dayTxt = UILabel()
    private let noOfEvents = UILabel()
    
    private let matchesSection = UIStackView()
    
    
    

    override func addViews() {
        // Add subviews to your custom view
        addSubview(listSection)
        listSection.addSubview(dayTxt)
        listSection.addSubview(noOfEvents)
        
        addSubview(matchesSection)
        
       
        
        
        
        
    }

    override func styleViews() {
        // Apply styles to your subviews
        
        
        
        dayTxt.text = day
        dayTxt.textColor = .black
        
        noOfEvents.text = day
        noOfEvents.textColor = .gray
        
        matchesSection.backgroundColor = .white
        
        matchesSection.axis = .vertical
        matchesSection.distribution = .fillEqually
        
        
    }

    override func setupConstraints() {
        // Set up Layout constraints
        
        listSection.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        dayTxt.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(24)
        }
        noOfEvents.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(24)
        }
        
        matchesSection.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(listSection.snp.bottom)
        }
        
        
    }

    override func setupGestureRecognizers() {
        // Configure gesture recognizers
    }

    override func setupBinding() {
        // Set up bindings
    }
}
