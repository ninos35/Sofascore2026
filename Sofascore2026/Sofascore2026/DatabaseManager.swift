
import GRDB
import Foundation

class DatabaseManager {
    
    static let shared: DatabaseManager = DatabaseManager()
    var dbQueue: DatabaseQueue!
    
    private init() {
        do {
            let databaseURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("sofascore.sqlite")
            
            dbQueue = try DatabaseQueue(path: databaseURL.path)
            
            try setupMigrations()
        } catch {
            fatalError("Database setup failed")
        }
    }
    
    private func setupMigrations() throws {
        
        var migrator: DatabaseMigrator = DatabaseMigrator()
        
        migrator.registerMigration("v1") { db in
            try db.create(table: "league") { t in
                t.primaryKey("id", .integer)
                t.column("name", .text).notNull()
                t.column("countryName", .text).notNull()
                t.column("logoUrl", .text).notNull()
            }
            try db.create(table: "event") { t in
                t.primaryKey("id", .integer)
                t.column("startTimestamp", .integer).notNull()
                t.column("statusCode", .text).notNull()
                t.column("homeScore", .integer)
                t.column("awayScore", .integer)
                t.column("round", .integer)
                
                t.column("homeTeamId", .integer).notNull()
                t.column("homeTeamName", .text).notNull()
                t.column("homeTeamLogoUrl", .text)
                t.column("homeTeamCountryName", .text)
                
                t.column("awayTeamId", .integer).notNull()
                t.column("awayTeamName", .text).notNull()
                t.column("awayTeamLogoUrl", .text)
                t.column("awayTeamCountryName", .text)
                
                t.column("leagueId", .integer).notNull()
                t.column("leagueName", .text).notNull()
                t.column("leagueCountryName", .text)
                t.column("leagueUrl", .text).notNull()
            }
        }
        
        try migrator.migrate(dbQueue)
    }
    
    func saveLeagues(_ leagues: [League]) throws {
        try dbQueue.write { db in
            for league in leagues {
                try league.insert(db, onConflict: .ignore)
            }
        }
    }
    
    func saveEvents(_ events: [Event]) throws {
        try dbQueue.write { db in
            for event in events {
                try event.insert(db, onConflict: .ignore)
            }
        }
    }
    
    func leagueCount() throws -> Int {
        try dbQueue.read { db in
            try League.fetchCount(db)
        }
    }
    
    func eventCount() throws -> Int {
        try dbQueue.read { db in
            try Event.fetchCount(db)
        }
    }
    
    func clearAllData() throws {
        try dbQueue.write { db in
            try Event.deleteAll(db)
            try League.deleteAll(db)
        }
    }
}
