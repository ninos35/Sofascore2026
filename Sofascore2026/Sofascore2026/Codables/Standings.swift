
struct Standings: Decodable {
    let team: Team
    let position: Int32
    let matches: Int32
    let wins: Int32
    let losses: Int32
    let draws: Int32
    let points: Int32?
    let percentage: Double?
    let scoreFor: Int32?
    let scoreAgainst: Int32?
    let scoreFormatted: String?
    
    var gb: Double? = nil
    var str: String? = nil
}
