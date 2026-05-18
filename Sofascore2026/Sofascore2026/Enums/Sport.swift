//
//  Sport.swift
//  Sofascore2026
//
//  Created by akademija on 18.05.2026..
//

enum Sport {
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
    var urlKey: String {
        switch self {
        case .football:
            return "football"
        case .basketball:
            return "basketball"
        case .americanFootball:
            return "am-football"
        }
    }
}
