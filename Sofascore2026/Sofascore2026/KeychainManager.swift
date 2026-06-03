//
//  KeychainManager.swift
//  Sofascore2026
//
//  Created by akademija on 26.05.2026..
//
import KeychainAccess
class KeychainManager {
    
    static let shared = KeychainManager()
    
    private let keychain = Keychain(service: "sofascore")
    
    private let tokenKey = "userToken"
    private let usernameKey = "username"
    
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
