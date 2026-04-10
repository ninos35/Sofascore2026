//
//  SettingsViewController.swift
//  Sofascore2026
//
//  Created by akademija on 28.03.2026..
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    let titleLabel: UILabel = UILabel()
    let dismissLabel: UILabel = UILabel()
    
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
        titleLabel.font = Constants.Fonts.bold
        titleLabel.textAlignment = .center
        
        dismissLabel.text = "Dismiss"
        dismissLabel.textColor = Constants.Colors.lightBlue
        dismissLabel.font = Constants.Fonts.regular
        dismissLabel.textAlignment = .center
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        dismissLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.centerY.equalToSuperview()
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
