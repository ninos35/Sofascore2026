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
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc private func loginTapped() {
        guard let username = loginView.usernameTextField.text, !username.isEmpty,
              let password = loginView.passwordTextField.text, !password.isEmpty
        else {
            Alerts.showLoginError(on: self)
            return
        }
        
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
