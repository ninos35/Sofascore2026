//
//  SettingsViewController.swift
//  Sofascore2026
//
//  Created by akademija on 28.03.2026..
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private let settingsView: SettingsView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        gestureRecognisers()
    }
    
    func addViews() {
        view.addSubview(settingsView)
    }
    
    func styleViews() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        settingsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func gestureRecognisers() {
        settingsView.dismissLabel.isUserInteractionEnabled = true
        let dismissTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        settingsView.dismissLabel.addGestureRecognizer(dismissTapGesture)
        
        settingsView.logoutLabel.isUserInteractionEnabled = true
        let logoutTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLogout))
        settingsView.logoutLabel.addGestureRecognizer(logoutTapGesture)
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true)
    }
    
    @objc func handleLogout() {
        KeychainManager.shared.deleteData()
        
        try? DatabaseManager.shared.clearAllData()
        
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navigationController
        }
    }
}
