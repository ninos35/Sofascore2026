
enum TournamentDataLoader {
    static func loadMatches(for tournamentId: Int) async throws -> [Event] {
        return try await APIClient.shared.getTournamentMatches(id: tournamentId)
    }
    
    static func loadStandings(for tournamentId: Int) async throws -> [Standings] {
        return try await APIClient.shared.getTournamentStandings(id: tournamentId)
    }
}
