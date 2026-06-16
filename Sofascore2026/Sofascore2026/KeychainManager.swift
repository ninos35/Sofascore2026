
import KeychainAccess

class KeychainManager {
    
    static let shared: KeychainManager = KeychainManager()
    
    private let keychain: Keychain = Keychain(service: "sofascore")
    
    private let tokenKey: String = "userToken"
    private let usernameKey: String = "username"
    
    func saveToken(token: String) {
        keychain[tokenKey] = token
    }
    
    func getToken() -> String? {
        keychain[tokenKey]
    }
    
    func deleteToken() {
        keychain[tokenKey] = nil
    }
    
    func saveUsername(username: String) {
        keychain[usernameKey] = username
    }
    
    func getUsername() -> String? {
        keychain[usernameKey]
    }
    
    func deleteUsername() {
        keychain[usernameKey] = nil
    }
    
    func deleteData() {
        deleteToken()
        deleteUsername()
    }
}
