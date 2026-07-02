
enum EventDetailsHelper {
    static func generateTitle(match: Event, sport: Sport) -> String {
        let sportName: String = sport.name
        let countryName: String = match.league.country?.name ?? ""
        let leagueName: String = match.league.name
        let round: String = match.round?.toString() ?? ""
        return sportName + ", " + countryName + ", " + leagueName + ", Round " + round
    }
    
    static func processIncidents(_ data: [Incident]) -> [Incident] {
        let chronological = data.sorted { $0.minute < $1.minute }
        
        var currentHomeScore: Int32 = 0
        var currentAwayScore: Int32 = 0
        
        let processed = chronological.map { incident in
            var i = incident
            
            if incident.type == .goal {
                if incident.isHomeTeam == true {
                    currentHomeScore += incident.scoreDiff ?? 0
                } else {
                    currentAwayScore += incident.scoreDiff ?? 0
                }
            }
            
            i.homeScore = currentHomeScore
            i.awayScore = currentAwayScore
            return i
        }
        
        return processed.reversed()
    }
}
