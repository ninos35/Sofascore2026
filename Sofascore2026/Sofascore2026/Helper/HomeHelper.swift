
enum HomeHelper {
    
    static func groupAndSortEvents(_ data: [Event]) -> [Section] {
        let grouped = Dictionary(grouping: data) { $0.league.id }
        
        let finalSections: [Section] = grouped.compactMap { (key, events) in
            guard let firstLeague = events.first?.league else { return nil }
            return Section(header: .league(firstLeague), events: events)
        }
        
        return finalSections.sorted { (section1, section2) in
            if case .league(let league1) = section1.header,
               case .league(let league2) = section2.header {
                return league1.id < league2.id
            }
            return false
        }
    }
    
    static func saveToDatabase(events: [Event]) {
        let leagues = Array(Set(events.map { $0.league.id }))
            .compactMap { id in events.first { $0.league.id == id }?.league }
        
        do {
            try DatabaseManager.shared.saveLeagues(leagues)
            try DatabaseManager.shared.saveEvents(events)
        } catch {
            print("DB error: \(error)")
        }
    }
}
