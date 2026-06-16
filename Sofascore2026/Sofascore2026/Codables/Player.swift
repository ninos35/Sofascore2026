
struct Player: Decodable {
    let id: Int32
    let name: String?
    let shortName: String?
    let position: String?
    let jerseyNumber: String?
    let country: Country?
    let imageUrl: String
    let isForeign: Bool?
}
