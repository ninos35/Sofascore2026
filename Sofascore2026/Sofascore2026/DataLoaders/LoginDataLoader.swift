
enum LoginDataLoader {
    static func login(request: LoginRequest) async throws -> LoginResponse {
        return try await APIClient.shared.login(loginRequest: request)
    }
}
