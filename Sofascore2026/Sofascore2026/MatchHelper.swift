//
//  MatchHelper.swift
//  Sofascore2026
//
//  Created by akademija on 31.03.2026..
//

import Foundation

enum MatchHelper {
    
    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }()
    
    static func formatTime(date: Date) -> String {
        return timeFormatter.string(from: date)
    }
}
