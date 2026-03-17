//
//  ViewController.swift
//  Sofascore2026
//
//  Created by akademija on 05.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
    
    private let sports: [Sport] = [
        Sport(name: "Football", icon: "Icon"),
        Sport(name: "Basketball", icon: "icon_basketball"),
        Sport(name:"Am. Football", icon: "icon_american_football")
    ]
    
    private var sendDates: [String] = []
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        let dataSource = Homework2DataSource()

        
//      frame dio (nije dio druge zadace)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"

        for i in -3...3 {
            let day = Calendar.current.date(byAdding: .day, value: i, to: Date())
            
            if let date = day {
                let datum = formatter.string(from: date)
                var dan = dateFormatter.string(from: date)
                
                if dan == dateFormatter.string(from: Date()) {
                    dan = "TODAY"
                }
                let txt = "\(dan.uppercased())\n\(datum.dropLast(5))"
                sendDates.append(txt)
        }
            
            
            let viewFrame = Frame(sports: sports,sentDates: sendDates)
                    
            let league = LeagueView()
            league.set(league: dataSource.laLigaLeague())
         
            view.addSubview(viewFrame)
//       kraj frame dijela
            
            
            view.addSubview(league)
            
            let match1 = Matches()
            match1.set(event: dataSource.laLigaEvents()[0])
            league.addSubview(match1)
            let match2 = Matches()
            match2.set(event: dataSource.laLigaEvents()[1])
            league.addSubview(match2)
            let match3 = Matches()
            match3.set(event: dataSource.laLigaEvents()[2])
            league.addSubview(match3)
            let match4 = Matches()
            match4.set(event: dataSource.laLigaEvents()[3])
            league.addSubview(match4)
                    
            
            viewFrame.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(144)
            }
            league.snp.makeConstraints { make in
                make.height.equalTo(56)
                make.top.equalTo(viewFrame.snp.bottom)
                make.width.equalToSuperview()
            }
                    
            match1.snp.makeConstraints { make in
                make.top.equalTo(league.snp.bottom)
                make.width.equalToSuperview()
            }
            match2.snp.makeConstraints { make in
                make.top.equalTo(match1.snp.bottom).offset(56)
                make.width.equalToSuperview()
            }
            match3.snp.makeConstraints { make in
                make.top.equalTo(match2.snp.bottom).offset(56)
                make.width.equalToSuperview()
            }
            match4.snp.makeConstraints { make in
                make.top.equalTo(match3.snp.bottom).offset(56)
                make.width.equalToSuperview()
            }

            
        }
        
        
    }
    
}
