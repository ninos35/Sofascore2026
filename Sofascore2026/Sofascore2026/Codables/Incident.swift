
struct Incident: Decodable {
    let type: IncidentType
    let minute: Int32
    let isHomeTeam: Bool?
    let extraMinute: Int32?
    let player: String?
    let scoreDiff: Int32?
    let score: String?
    let description: String?
    
    var homeScore: Int32? = nil
    var awayScore: Int32? = nil
}
