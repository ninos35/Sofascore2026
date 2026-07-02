
enum HomeDataLoader {
    static func loadAllEvents(for sport: Sport) async throws -> [Event] {
        return try await APIClient.shared.getAllEvents(sport: sport.urlKey)
    }
}
