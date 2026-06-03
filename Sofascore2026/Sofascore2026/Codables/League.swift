//
//  League.swift
//  Sofascore2026
//
//  Created by akademija on 08.05.2026..
//

import GRDB

struct League: Codable, FetchableRecord, PersistableRecord {
    let id: Int
    let name: String
    let country: Country
    let logoUrl: String
    
    static let databaseTableName = "league"
    
    init(id: Int, name: String, country: Country, logoUrl: String) {
            self.id = id
            self.name = name
            self.country = country
            self.logoUrl = logoUrl
        }

    init(row: Row) {
        id = row["id"]
        name = row["name"]
        country = Country(name: row["countryName"])
        logoUrl = row["logoUrl"]
    }
    
    func encode(to container: inout PersistenceContainer) {
        container["id"] = id
        container["name"] = name
        container["countryName"] = country.name
        container["logoUrl"] = logoUrl
    }
}
