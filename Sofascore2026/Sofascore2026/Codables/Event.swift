
import GRDB

struct Event: Decodable, FetchableRecord, PersistableRecord {
    let id: Int64
    let homeTeam: Team
    let awayTeam: Team
    let startTimestamp: Int64
    let status: EventStatus
    let league: League
    let homeScore: Int32?
    let awayScore: Int32?
    let round: Int32?
    
    static let databaseTableName = "event"
    
    init(row: Row) {
        id = row["id"]
        homeTeam = Team(
            id: row["homeTeamId"],
            name: row["homeTeamName"],
            logoUrl: row["homeTeamLogoUrl"],
            country: Country(name: row["homeTeamCountryName"]))
        awayTeam = Team(
            id: row["awayTeamId"],
            name: row["awayTeamName"],
            logoUrl: row["awayTeamLogoUrl"],
            country: Country(name: row["awayTeamCountryName"]))
        startTimestamp = row["startTimestamp"]
        
        let statusRaw: String = row["statusCode"]
        status = EventStatus(rawValue: statusRaw) ?? .notStarted
        
        league = League(id: row["leagueId"], name: row["leagueName"], country: Country(name: row["leagueCountryName"]), logoUrl: row["leagueUrl"])
        homeScore = row["homeScore"]
        awayScore = row["awayScore"]
        round = row["round"]
    }
    
    func encode(to container: inout PersistenceContainer) {
        container["id"] = id
        container["startTimestamp"] = startTimestamp
        container["homeScore"] = homeScore
        container["awayScore"] = awayScore
        container["round"] = round
        
        container["statusCode"] = status.rawValue
        
        container["homeTeamId"] = homeTeam.id
        container["homeTeamName"] = homeTeam.name
        container["homeTeamLogoUrl"] = homeTeam.logoUrl
        container["homeTeamCountryName"] = homeTeam.country?.name
        
        container["awayTeamId"] = awayTeam.id
        container["awayTeamName"] = awayTeam.name
        container["awayTeamLogoUrl"] = awayTeam.logoUrl
        container["awayTeamCountryName"] = awayTeam.country?.name
        
        container["leagueId"] = league.id
        container["leagueName"] = league.name
        container["leagueCountryName"] = league.country?.name
        container["leagueUrl"] = league.logoUrl
    }
}
