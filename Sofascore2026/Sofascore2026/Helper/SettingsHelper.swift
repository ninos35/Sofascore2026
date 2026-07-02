
enum SettingsHelper {
    
    static func getSettingsData() -> (username: String, leagueCount: Int, eventCount: Int) {
        let username = KeychainManager.shared.getUsername() ?? "No Username"
        let leagueCount = (try? DatabaseManager.shared.leagueCount()) ?? 0
        let eventCount = (try? DatabaseManager.shared.eventCount()) ?? 0
        
        return (username, leagueCount, eventCount)
    }
    
    static func clearUserData() {
        KeychainManager.shared.deleteData()
        try? DatabaseManager.shared.clearAllData()
    }
}
