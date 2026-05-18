//
//  Event.swift
//  Sofascore2026
//
//  Created by akademija on 08.05.2026..
//

struct Event: Codable {
    let id: Int64
    let homeTeam: Team
    let awayTeam: Team
    let startTimestamp: Int64
    let status: EventStatus
    let league: League
    let homeScore: Int?
    let awayScore: Int?
}
