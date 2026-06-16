
import Foundation

class APIClient {
    
    static let shared: APIClient = APIClient()
    
    func login(loginRequest: LoginRequest) async throws -> LoginResponse {
        guard let url: URL = URL(string: Constants.URLs.dataSourceUrl + "/login") else {
            throw URLError(.badURL)
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(loginRequest)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
    
    func getIncidents(id: Int64) async throws -> [Incident] {
        guard let url: URL = URL(string: Constants.URLs.dataSourceUrl + "/events/\(id)/incidents") else {
            throw URLError(.badURL)
        }
        
        guard let token: String = KeychainManager.shared.getToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Incident].self, from: data)
    }
    
    func getAllEvents(sport: String) async throws -> [Event] {
        guard let url: URL = URL(string: Constants.URLs.dataSourceUrl + "/events?sport=\(sport)") else {
            throw URLError(.badURL)
        }
        
        guard let token: String = KeychainManager.shared.getToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Event].self, from: data)
    }
    
    func getAllEventsOld(sport: String, completion: @escaping ([Event]?) -> Void) {
        guard let url: URL = URL(string: Constants.URLs.dataSourceUrl + "/events?sport=\(sport)") else {
            completion(nil)
            return
        }
        
        guard let token: String = KeychainManager.shared.getToken() else {
            completion(nil)
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let events = try JSONDecoder().decode([Event].self, from: data)
                completion(events)
            } catch {
                completion(nil)
            }
            
        }.resume()
    }
    
    func getTournamentMatches(id: Int) async throws -> [Event] {
        guard let url: URL = URL(string: Constants.URLs.dataSourceUrl + "/leagues/\(id)/matches") else {
            throw URLError(.badURL)
        }
        
        guard let token: String = KeychainManager.shared.getToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Event].self, from: data)
    }
    
    func getTournamentStandings(id: Int) async throws -> [Standings] {
        guard let url: URL = URL(string: Constants.URLs.dataSourceUrl + "/leagues/\(id)/standings") else {
            throw URLError(.badURL)
        }
        
        guard let token: String = KeychainManager.shared.getToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Standings].self, from: data)
    }
    
    func getTeamInfo(id: Int) async throws -> TeamInfo {
        guard let url: URL = URL(string: Constants.URLs.dataSourceUrl + "/teams/\(id)") else {
            throw URLError(.badURL)
        }
        
        guard let token: String = KeychainManager.shared.getToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(TeamInfo.self, from: data)
    }
    
    func getTeamPlayers(id: Int) async throws -> [Player] {
        guard let url: URL = URL(string: Constants.URLs.dataSourceUrl + "/teams/\(id)/players") else {
            throw URLError(.badURL)
        }
        
        guard let token: String = KeychainManager.shared.getToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Player].self, from: data)
    }
    
    func getTeamTournaments(id: Int) async throws -> [League] {
        guard let url: URL = URL(string: Constants.URLs.dataSourceUrl + "/teams/\(id)/tournaments") else {
            throw URLError(.badURL)
        }
        
        guard let token: String = KeychainManager.shared.getToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([League].self, from: data)
    }
}
