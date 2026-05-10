//
//  Team.swift
//  Sofascore2026
//
//  Created by akademija on 08.05.2026..
//

struct Team: Codable {
    let id: Int
    let name: String
    let logoUrl: String
    let country: Country?
}
