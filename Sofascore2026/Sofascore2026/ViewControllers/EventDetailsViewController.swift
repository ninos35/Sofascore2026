//
//  EventDetailsViewController.swift
//  Sofascore2026
//
//  Created by akademija on 29.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class EventDetailsViewController: UIViewController {
    
    private let detailedMatchView = DetailedMatchView()
    
    private let titleView = UIView()
    private let titleImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.titleView = titleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
    }
    
    func addViews() {
        view.addSubview(detailedMatchView)
        
        titleView.addSubview(titleImageView)
        titleView.addSubview(titleLabel)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        titleLabel.font = Constants.Fonts.regularCondensed
        titleLabel.textColor = Constants.Colors.gray
    }
    
    func setupConstraints() {
        detailedMatchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleImageView.snp.makeConstraints { make in
            make.size.equalTo(16)
            make.leading.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleImageView.snp.trailing).offset(8)
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setEventDetails(match: Event) {
        titleImageView.image = UIImage(named: match.league?.name ?? "")
        
        let countryName: String = match.league?.country?.name ?? ""
        let leagueName: String = match.league?.name ?? ""
        titleLabel.text = countryName + ", " + leagueName
        
        detailedMatchView.set(detailedMatch: match)
    }
}
