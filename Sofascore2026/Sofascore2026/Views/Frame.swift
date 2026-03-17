//
//  Frame.swift
//  Sofascore2026
//
//  Created by akademija on 14.03.2026..
//
import SofaAcademic
import UIKit
import SnapKit

class Frame: BaseView {
    
    private let sports : [Sport]
    private let sentDates: [String]
    
    init(sports: [Sport],sentDates: [String]) {
        self.sports = sports
        self.sentDates = sentDates
        super.init()
    }
    
    
    
    private let headerRectangle = UIView()
    private let headerMain = UIView()
    private let headerTabs = UIStackView()
    private let calendarTabs = UIView()
    private let calendarTabsStack = UIStackView()
    
    private let sofascoreLockup = UIButton()
    private let icon1 = UIButton()
    private let icon2 = UIButton()
    
    
    
    override func addViews() {
        // Add subviews to your custom view
        addSubview(headerRectangle)
        headerRectangle.addSubview(headerMain)
        headerRectangle.addSubview(headerTabs)
        headerRectangle.addSubview(calendarTabs)
        
        headerMain.addSubview(sofascoreLockup)
        headerMain.addSubview(icon1)
        headerMain.addSubview(icon2)
        
        calendarTabs.addSubview(calendarTabsStack)
        
        for sport in sports {
            let button = UIButton(configuration: .plain())
            
            button.setTitle(sport.name, for: .normal)
            button.setImage(UIImage(named: sport.icon), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tintColor = .white
            button.configuration?.imagePlacement = .top
            button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
            button.configuration?.background.cornerRadius = 0
            headerTabs.addArrangedSubview(button)
        }

        
        for day in sentDates {

                var config = UIButton.Configuration.plain()
                
                config.title = day
                config.titleAlignment = .center
            
                config.baseForegroundColor = .white
                config.background.cornerRadius = 0
                config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                let button = UIButton(configuration: config)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.titleLabel?.numberOfLines = 2
                button.titleLabel?.lineBreakMode = .byClipping
                button.titleLabel?.adjustsFontSizeToFitWidth = true
                button.contentVerticalAlignment = .center
                button.contentHorizontalAlignment = .center
                calendarTabsStack.addArrangedSubview(button)
            }
        }
    

    override func styleViews() {
        // Apply styles to your subviews
        headerRectangle.backgroundColor = UIColor(red: 55/255, green: 77/255, blue: 245/255, alpha: 1)
        calendarTabs.backgroundColor = UIColor(red: 19/255, green: 39/255, blue: 186/255, alpha: 1)
        
        sofascoreLockup.setImage(UIImage(named: "sofascore_lockup"), for: .normal)

        icon1.setImage(UIImage(named: "Icon 1"), for: .normal)
        icon2.setImage(UIImage(named: "Icon 2"), for: .normal)

    }

    override func setupConstraints() {
        // Set up Layout constraints
        headerRectangle.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(144)
            make.width.equalToSuperview()

            }
        headerMain.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalToSuperview()
            }
        headerTabs.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.top.equalTo(headerMain.snp.bottom)
            make.height.equalTo(48)
            make.width.equalToSuperview()
            }
        calendarTabs.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.top.equalTo(headerTabs.snp.bottom)
            make.height.equalTo(48)
            make.width.equalToSuperview()
        }
//        Header
        sofascoreLockup.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(20)
            make.width.equalTo(132)
            }
        icon1.snp.makeConstraints{ make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.width.equalTo(48)
            }
        icon2.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-48)
            make.top.equalToSuperview()
            make.height.width.equalTo(48)
            }
        
        headerTabs.axis = .horizontal
        headerTabs.distribution = .fillEqually
        
        calendarTabsStack.axis = .horizontal
        calendarTabsStack.distribution = .fillEqually
        calendarTabsStack.translatesAutoresizingMaskIntoConstraints = false
        calendarTabsStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func setupGestureRecognizers() {
        // Configure gesture recognizers
    }

    override func setupBinding() {
        // Set up bindings
    }
}
