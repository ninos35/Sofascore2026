//
//  MatchStatusView.swift
//  Sofascore2026
//
//  Created by akademija on 19.03.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class MatchStatusView: BaseView {
    
    private let dateTimeLabel = UILabel()
    private let statusLabel = UILabel()
    
    private let dividerView = UIView()
    
    override func addViews() {
        addSubview(dateTimeLabel)
        addSubview(statusLabel)
        addSubview(dividerView)
    }
    
    override func styleViews() {
        
        dateTimeLabel.textColor = Constants.Colors.gray
        dateTimeLabel.font = Constants.Fonts.regularCondensed
        dateTimeLabel.textAlignment = .center
        
        statusLabel.textColor = Constants.Colors.gray
        statusLabel.font = Constants.Fonts.regularCondensed
        statusLabel.textAlignment = .center
        
        dividerView.backgroundColor = Constants.Colors.lightGray
    }
    
    override func setupConstraints() {
        
        dateTimeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(4)
            make.top.equalToSuperview().offset(10)
        }
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(4)
            make.top.equalTo(dateTimeLabel.snp.bottom).offset(4)
        }
        dividerView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(1)
            make.centerY.equalToSuperview()
        }
    }
    
    func set(event: Event){
        let date: Date = Date(timeIntervalSince1970: Double(event.startTimestamp))
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        dateTimeLabel.text = String(formatter.string(from: date))
        
        switch event.status {
        case .notStarted:
            statusLabel.text = "-"
            
        case .inProgress:
            statusLabel.textColor = Constants.Colors.red
            statusLabel.text = String(Int(Date().timeIntervalSince(date)/60)) + "'"
            
        case .halftime:
            statusLabel.textColor = Constants.Colors.red
            statusLabel.text = "HT"
            
        case .finished:
            statusLabel.text = "FT"
        }
    }
}
