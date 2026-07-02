
enum LoginHelper {
    
    static func saveSession(response: LoginResponse) {
        KeychainManager.shared.saveToken(token: response.token)
        KeychainManager.shared.saveUsername(username: response.name)
    }
}
