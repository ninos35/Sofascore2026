
enum EventDetailsDataLoader {
    static func loadIncidents(for matchId: Int64) async throws -> [Incident] {
        return try await APIClient.shared.getIncidents(id: matchId)
    }
}
