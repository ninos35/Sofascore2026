//
//  LoginViewController.swift
//  Sofascore2026
//
//  Created by akademija on 25.05.2026..
//


import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let loginView: LoginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupConstraints()
        gestureRecognisers()
    }
    
    func addViews() {
        view.addSubview(loginView)
    }
    
    func setupConstraints() {
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func gestureRecognisers() {
        loginView.onLoginTapped = { [weak self] username, password in
            guard let self = self else { return }
            
            if username.isEmpty || password.isEmpty {
                Alerts.showLoginError(on: self)
                return
            }
            loginTapped(username: username, password: password)
        }
    }
    
    func loginTapped(username: String, password: String) {
        
        let loginRequest = LoginRequest(username: username, password: password)
        
        Task {
            do {
                let response = try await APIClient.shared.login(loginRequest: loginRequest)
                await MainActor.run {
                    KeychainManager.shared.saveToken(token: response.token)
                    KeychainManager.shared.saveUsername(username: response.name)
                    
                    let viewController = ViewController()
                    let navigationController = UINavigationController(rootViewController: viewController)
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        window.rootViewController = navigationController
                    }
                }
            } catch {
                Alerts.showLoginError(on: self)
            }
        }
    }
}
