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
    
    private let sportsStackView = UIStackView()
    
    override func addViews() {
     addSubview(sportsStackView)
    }

    override func styleViews() {
        sportsStackView.backgroundColor = Constants.Colors.lightBlue
        sportsStackView.axis = .horizontal
    }

    override func setupConstraints() {
        sportsStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }

//    func set(sport: String, imageName: String){
//        <#function body#>
//    }
//    
//    frame.snp.makeConstraints { make in
//        make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//        make.leading.trailing.equalToSuperview()
//        make.height.equalTo(48)
//    }
}
