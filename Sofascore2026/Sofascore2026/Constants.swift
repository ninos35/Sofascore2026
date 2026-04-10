//
//  Constants.swift
//  Sofascore2026
//
//  Created by akademija on 20.03.2026..
//

import UIKit

enum Constants {
    
    enum Colors {
        static let black = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        static let gray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
        static let lightGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.1)
        static let red = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
        static let lightBlue = UIColor(red: 55/255, green: 77/255, blue: 245/255, alpha: 1)
    }
    
    enum Fonts {
        static let regular = UIFont(name: "Roboto-Regular", size: 14)
        static let regularCondensed = UIFont(name: "RobotoCondensed-Regular", size: 12)
        static let bold = UIFont(name: "Roboto-Bold", size: 14)
        static let bigBold = UIFont(name: "Roboto-Bold", size: 32)
    }
    
    enum Sports {
        case football
        case basketball
        case americanFootball
        
        var name: String {
            switch self {
            case .football:
                return "Football"
            case .basketball:
                return "Basketball"
            case .americanFootball:
                return "Am. Football"
            }
        }
        
        var icon: String {
            switch self {
            case .football:
                return "icon_football"
            case .basketball:
                return "icon_basketball"
            case .americanFootball:
                return "icon_american_football"
            }
        }
    }
    
    enum Icons {
        static let logoIcon = "icon_logo"
        static let trophyIcon = "icon_trophy"
        static let settingsIcon = "icon_settings"
    }
    
    enum Vectors {
        static let backArrow = "back_arrow_vector"
        static let pointingVector = "pointing_vector"
    }
}
