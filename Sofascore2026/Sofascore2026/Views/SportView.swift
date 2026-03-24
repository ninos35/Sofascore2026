//
//  SportView.swift
//  Sofascore2026
//
//  Created by akademija on 20.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class SportView: BaseView {
    
    private var configuration = UIButton.Configuration.plain()
    
    private let sportButton = UIButton()
    
    private let underlineView = UIView()
    
    var stateChanged: ((SportView) -> Void)?
    
    var isSelected: Bool = false {
        didSet {
            underlineView.backgroundColor = isSelected ? .white : Constants.Colors.lightBlue
            stateChanged?(self)
        }
    }
    
    override func addViews() {
        addSubview(sportButton)
        addSubview(underlineView)
    }
    
    override func styleViews() {
        
        configuration.imagePlacement = .top
        configuration.titleAlignment = .center
        configuration.titleTextAttributesTransformer =
        UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = Constants.Fonts.regular
            return outgoing
        }
        configuration.baseForegroundColor = .white
        configuration.imagePadding = 4

        underlineView.layer.cornerRadius = 2
        underlineView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    override func setupConstraints() {
        
        sportButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        underlineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(4)
        }
    }
    
    override func setupGestureRecognizers() {
        sportButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc private func buttonClicked() {
        isSelected = true
    }
    
    func set(sport:(name: String, icon: String)) {
        
        configuration.title = sport.name
        configuration.image = UIImage(named: sport.icon)
        
        sportButton.configuration = configuration
    }
}
