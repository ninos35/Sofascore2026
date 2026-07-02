
import Foundation

class APIClient {
    
    static let shared: APIClient = APIClient()
    
    private enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    private func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        body: Data? = nil,
        requiresAuth: Bool = true
    ) async throws -> T {
        
        guard let url = URL(string: Constants.URLs.dataSourceUrl + endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        if requiresAuth {
            guard let token = KeychainManager.shared.getToken() else {
                throw URLError(.userAuthenticationRequired)
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func login(loginRequest: LoginRequest) async throws -> LoginResponse {
        let body = try JSONEncoder().encode(loginRequest)
        return try await request(endpoint: "/login", method: .post, body: body, requiresAuth: false)
    }
    
    func getIncidents(id: Int64) async throws -> [Incident] {
        return try await request(endpoint: "/events/\(id)/incidents")
    }
    
    func getAllEvents(sport: String) async throws -> [Event] {
        return try await request(endpoint: "/events?sport=\(sport)")
    }
    
    func getTournamentMatches(id: Int) async throws -> [Event] {
        return try await request(endpoint: "/leagues/\(id)/matches")
    }
    
    func getTournamentStandings(id: Int) async throws -> [Standings] {
        return try await request(endpoint: "/leagues/\(id)/standings")
    }
    
    func getTeamInfo(id: Int) async throws -> TeamInfo {
        return try await request(endpoint: "/teams/\(id)")
    }
    
    func getTeamPlayers(id: Int) async throws -> [Player] {
        return try await request(endpoint: "/teams/\(id)/players")
    }
    
    func getTeamTournaments(id: Int) async throws -> [League] {
        return try await request(endpoint: "/teams/\(id)/tournaments")
    }
}
