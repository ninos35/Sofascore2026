//
//  MatchHelper.swift
//  Sofascore2026
//
//  Created by akademija on 31.03.2026..
//

import Foundation

enum MatchHelper {
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    static func formatTime(date: Date) -> String {
        return timeFormatter.string(from: date)
    }
}
