
enum TournamentHelper {
    
    static func groupAndSortMatches(_ data: [Event]) -> [Section] {
        let groupedByRound = Dictionary(grouping: data) { event in
            return Int(event.round ?? 0)
        }
        
        let finalSections: [Section] = groupedByRound.map { (roundNumber, events) in
            return Section(header: .round(Int32(roundNumber)), events: events)
        }
        
        return finalSections.sorted { (section1, section2) in
            if case .round(let num1) = section1.header,
               case .round(let num2) = section2.header {
                return num1 < num2
            }
            return false
        }
    }
    
    static func processStandings(_ standings: [Standings], sport: Sport, teamStreaks: [Int: String]) -> [Standings] {
        var sortedRows = standings.sorted { $0.position < $1.position }
        
        if sport == .basketball {
            let leader = sortedRows.first
            sortedRows = sortedRows.map { s in
                var updated = s
                if let leader = leader {
                    updated.gb = Double((leader.wins - s.wins) + (s.losses - leader.losses)) / 2.0
                }
                updated.str = teamStreaks[Int(s.team.id)]
                return updated
            }
        }
        return sortedRows
    }
    
    static func calculateStreaks(from events: [Event]) -> [Int: String] {
        var teamEvents: [Int: [Event]] = [:]
        
        for event in events {
            teamEvents[Int(event.homeTeam.id), default: []].append(event)
            teamEvents[Int(event.awayTeam.id), default: []].append(event)
        }
        
        var streaks: [Int: String] = [:]
        
        for (teamId, matches) in teamEvents {
            let sorted = matches.sorted { $0.startTimestamp > $1.startTimestamp }
            
            var count = 0
            var lastResult: String? = nil
            
            for match in sorted {
                guard let homeScore = match.homeScore,
                      let awayScore = match.awayScore else { continue }
                
                let isHome = match.homeTeam.id == teamId
                let result: String
                
                if homeScore == awayScore {
                    result = "D"
                } else if (isHome && homeScore > awayScore) || (!isHome && awayScore > homeScore) {
                    result = "W"
                } else {
                    result = "L"
                }
                
                if lastResult == nil { lastResult = result }
                if result == lastResult {
                    count += 1
                } else {
                    break
                }
            }
            
            if let last = lastResult {
                streaks[teamId] = "\(last)\(count)"
            }
        }
        
        return streaks
    }
}
