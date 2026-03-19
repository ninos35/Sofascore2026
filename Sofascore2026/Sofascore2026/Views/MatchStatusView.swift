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
        
        dateTimeLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
        dateTimeLabel.font = UIFont(name: "RobotoCondensed-Regular", size: 12)
        dateTimeLabel.textAlignment = .center
        
        statusLabel.textColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
        statusLabel.font = UIFont(name: "RobotoCondensed-Regular", size: 12)
        statusLabel.textAlignment = .center
        
        dividerView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.1)
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
            make.top.equalToSuperview().offset(30)
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
            statusLabel.textColor = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
            statusLabel.text = String(Int(Date().timeIntervalSince(date)/60)) + "'"
            
        case .halftime:
            statusLabel.textColor = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
            statusLabel.text = "HT"

        case .finished:
            statusLabel.text = "FT"
        }
    }
}
