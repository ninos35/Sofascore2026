
import Foundation

enum MatchHelper {
    
    private static let timeFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private static let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy."
        return formatter
    }()
    
    static func formatTime(date: Date) -> String {
        return timeFormatter.string(from: date)
    }
    
    static func formatDate(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
