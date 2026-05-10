//
//  APIClient.swift
//  Sofascore2026
//
//  Created by akademija on 09.05.2026..
//

import Foundation

class APIClient {
    
    func getAllEvents(sport: String) async throws -> [Event] {
        
        guard let url = URL(string: Constants.URLs.dataSourceUrl + "/events?sport=\(sport)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode([Event].self, from: data)
    }
    
    func getAllEventsOld(sport: String, completion: @escaping ([Event]?) -> Void) {
        
        guard let url = URL(string: Constants.URLs.dataSourceUrl + "/events?sport=\(sport)") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
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
