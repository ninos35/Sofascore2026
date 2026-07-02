
enum TeamHelper {
    static func calculateForeignPlayersCount(from players: [Player]) -> Int {
        return players.filter { $0.isForeign == true }.count
    }
}
