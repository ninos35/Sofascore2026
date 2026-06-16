
struct Team: Decodable {
    let id: Int32
    let name: String
    let logoUrl: String
    let country: Country?
}
