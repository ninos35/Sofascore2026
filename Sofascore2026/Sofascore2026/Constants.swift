
import UIKit

enum Constants {
    
    enum Colors {
        static let black = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        static let lightBlack = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.1)
        static let gray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.4)
        static let lightGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.1)
        static let systemGray = UIColor(red: 239/255, green: 243/255, blue: 247/255, alpha: 1)
        static let red = UIColor(red: 233/255, green: 48/255, blue: 48/255, alpha: 1)
        static let lightBlue = UIColor(red: 55/255, green: 77/255, blue: 245/255, alpha: 1)
        static let endPeriod = UIColor(red: 247/255, green: 246/255, blue: 239/255, alpha: 1)
        static let dirtyYellow = UIColor(red: 240/255, green: 238/255, blue: 223/255, alpha: 1)
        static let blueGray = UIColor(red: 192/255, green: 207/255, blue: 228/255, alpha: 0.2)
    }
    
    enum Fonts {
        static let regular = UIFont(name: "Roboto-Regular", size: 14)
        static let regularCondensed = UIFont(name: "RobotoCondensed-Regular", size: 12)
        static let smallBold = UIFont(name: "Roboto-Bold", size: 12)
        static let bold = UIFont(name: "Roboto-Bold", size: 14)
        static let bold16 = UIFont(name: "Roboto-Bold", size: 16)
        static let mediumBold = UIFont(name: "Roboto-Bold", size: 20)
        static let bigBold = UIFont(name: "Roboto-Bold", size: 32)
    }
    
    enum Icons {
        static let logoIcon = "icon_logo"
        static let trophyIcon = "icon_trophy"
        static let settingsIcon = "icon_settings"
        static let playersIcon = "icon_players"
    }
    
    enum IncidentIcons {
        static let scoreIcon = "icon_goal"
        static let twoPointsIcon = "icon_two_points"
        static let threePointsIcon = "icon_three_points"
        static let yellowCard = "yellow_card"
    }
    
    enum Vectors {
        static let backArrow = "back_arrow_vector"
        static let pointingVector = "pointing_vector"
    }
    
    enum URLs {
        static let dataSourceUrl = "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"
    }
    
    enum Tabs {
        case matches
        case standings
        case details
        case squad
        
        var title: String {
            switch self {
            case .matches:
                "Matches"
            case .standings:
                "Standings"
            case .details:
                "Details"
            case .squad:
                "Squad"
            }
        }
    }
}
