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
    
    private let detailedMatchView: DetailedMatchView = DetailedMatchView()
    
    private let backButtonView: UIView = UIView()
    private let backImageView: UIImageView = UIImageView()
    
    private let titleView: UIView = UIView()
    private let titleImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        let backButton = UIBarButtonItem(customView: backButtonView)
        
        self.navigationItem.titleView = titleView
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
        backButton.hidesSharedBackground = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()
    }
    
    func addViews() {
        view.addSubview(detailedMatchView)
        
        backButtonView.addSubview(backImageView)
        
        titleView.addSubview(titleImageView)
        titleView.addSubview(titleLabel)
    }
    
    func styleViews() {
        view.backgroundColor = .white
        
        backImageView.image = UIImage(named: Constants.Vectors.backArrow)
        backImageView.contentMode = .scaleAspectFit
        
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
            make.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleImageView.snp.trailing).offset(8)
            make.top.bottom.equalToSuperview()
        }
        
        backImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(16)
        }
    }
    
    func setupGestureRecognizers() {
        backImageView.isUserInteractionEnabled = true
        
        let backTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedBack))
        backImageView.addGestureRecognizer(backTapGesture)
    }
    
    @objc func clickedBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func getTitle(match: Event) -> String {
        let countryName: String = match.league?.country?.name ?? ""
        let leagueName: String = match.league?.name ?? ""
        return countryName + ", " + leagueName
    }
    
    func setEventDetails(match: Event) {
        titleImageView.image = UIImage(named: match.league?.name ?? "")
        
        titleLabel.text = getTitle(match: match)
        
        detailedMatchView.set(detailedMatch: match)
    }
}
