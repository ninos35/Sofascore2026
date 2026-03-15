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
        
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"

        
//        let today = Date()
//        let viewingDay = formatter.string(from: today)
        
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
//            let dataSource = Homework2DataSource()
//            let matchesFrame = Matches(day: viewingDay, events: [(dataSource.laLigaLeague(), dataSource.laLigaEvents())])
                    
                    
            view.addSubview(viewFrame)
//            view.addSubview(matchesFrame)
            
            
            viewFrame.translatesAutoresizingMaskIntoConstraints=false
            viewFrame.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(144)
            }
//            matchesFrame.translatesAutoresizingMaskIntoConstraints = false
//            matchesFrame.snp.makeConstraints { make in
//                make.top.equalTo(viewFrame.snp.bottom)
//                make.width.equalToSuperview()
//            }
            
            
        }
        
        
    }
    
}
