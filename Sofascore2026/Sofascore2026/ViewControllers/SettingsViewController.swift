//
//  SettingsViewController.swift
//  Sofascore2026
//
//  Created by akademija on 28.03.2026..
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    let titleLabel = UILabel()
    let dismissLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        setupDismiss()
    }
    
    func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(dismissLabel)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Settings"
        dismissLabel.font = Constants.Fonts.bold
        
        dismissLabel.text = "Dismiss"
        dismissLabel.textColor = Constants.Colors.lightBlue
        dismissLabel.font = Constants.Fonts.regular
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
        }
        dismissLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func setupDismiss() {
        dismissLabel.isUserInteractionEnabled = true
        let dismissTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        dismissLabel.addGestureRecognizer(dismissTapGesture)
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true)
    }
}
