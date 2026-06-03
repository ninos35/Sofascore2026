//
//  LoginView.swift
//  Sofascore2026
//
//  Created by akademija on 25.05.2026..
//

import SofaAcademic
import UIKit
import SnapKit

class LoginView: BaseView {
    
    private let logoImageView: UIImageView = UIImageView()
    
    private let loginLabel: UILabel = UILabel()
    
    private let usernameTextField: UITextField = UITextField()
    private let passwordTextField: UITextField = UITextField()
    
    private let loginButton: UIButton = UIButton()
    
    private let sloganLabel: UILabel = UILabel()
    
    var onLoginTapped: ((String, String) -> Void)?
    
    override func addViews() {
        addSubview(logoImageView)
        addSubview(loginLabel)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(sloganLabel)
    }
    
    override func styleViews() {
        
        self.backgroundColor = Constants.Colors.lightBlue
        
        logoImageView.image = UIImage(named: Constants.Icons.logoIcon)
        logoImageView.contentMode = .scaleAspectFill
        
        loginLabel.font = Constants.Fonts.bigBold
        loginLabel.textColor = .white
        loginLabel.text = "Login to continue"
        
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = Constants.Colors.gray
        
        sloganLabel.font = Constants.Fonts.regular
        sloganLabel.textColor = .white
        sloganLabel.text = "Live scores for every sport"
    }
    
    override func setupGestureRecognizers() {
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    
    @objc private func loginAction() {
        let username: String = usernameTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        
        onLoginTapped?(username,password)
    }
    
    override func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(128)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(150)
            make.centerX.equalToSuperview()
        }
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(100)
            make.width.equalTo(200)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(100)
            make.width.equalTo(200)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        sloganLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
    }
}
