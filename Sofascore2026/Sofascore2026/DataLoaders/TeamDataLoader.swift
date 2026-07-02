
enum TeamDataLoader {
    static func loadTeamInfo(for teamId: Int) async throws -> TeamInfo {
        return try await APIClient.shared.getTeamInfo(id: teamId)
    }
    
    static func loadTeamPlayers(for teamId: Int) async throws -> [Player] {
        return try await APIClient.shared.getTeamPlayers(id: teamId)
    }
    
    static func loadTeamTournaments(for teamId: Int) async throws -> [League] {
        return try await APIClient.shared.getTeamTournaments(id: teamId)
    }
}
