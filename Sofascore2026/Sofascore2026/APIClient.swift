//
//  APIClient.swift
//  Sofascore2026
//
//  Created by akademija on 09.05.2026..
//

import Foundation

class APIClient {
    
    static let shared = APIClient()
    
    func login(loginRequest: LoginRequest) async throws -> LoginResponse {
        guard let url = URL(string: Constants.URLs.dataSourceUrl + "/login") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(loginRequest)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
    
    func getAllEvents(sport: String) async throws -> [Event] {
        
        guard let url = URL(string: Constants.URLs.dataSourceUrl + "/events?sport=\(sport)") else {
            throw URLError(.badURL)
        }
        
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([Event].self, from: data)
    }
    
    func getAllEventsOld(sport: String, completion: @escaping ([Event]?) -> Void) {
        
        guard let url = URL(string: Constants.URLs.dataSourceUrl + "/events?sport=\(sport)") else {
            completion(nil)
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
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
}
