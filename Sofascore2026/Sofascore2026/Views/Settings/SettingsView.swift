
import SofaAcademic
import UIKit
import SnapKit

class SettingsView: BaseView {
    
    private let headerView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    
    private let userDataLabel: UILabel = UILabel()
    private let usernameLabel: UILabel = UILabel()
    private let leaguesLabel: UILabel = UILabel()
    private let eventsLabel: UILabel = UILabel()
    private let dividerView: UIView = UIView()
    private let dismissImageView: UIImageView = UIImageView()
    private let logoutLabel: UILabel = UILabel()
    
    private let aboutView: AboutView = AboutView()
    
    private let logoImageView: UIImageView = UIImageView()
    
    var dismissClicked: (() -> Void)?
    var logoutClicked: (() -> Void)?
    
    override func addViews() {
        addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(dismissImageView)
        
        addSubview(userDataLabel)
        addSubview(usernameLabel)
        addSubview(leaguesLabel)
        addSubview(eventsLabel)
        addSubview(dividerView)
        addSubview(aboutView)
        addSubview(logoutLabel)
        addSubview(logoImageView)
    }
    
    override func styleViews() {
        backgroundColor = .white
        
        headerView.backgroundColor = Constants.Colors.lightBlue
        
        userDataLabel.text = "User data"
        userDataLabel.textColor = Constants.Colors.black
        userDataLabel.font = Constants.Fonts.bold16
        userDataLabel.textAlignment = .center
        
        titleLabel.text = "Settings"
        titleLabel.font = Constants.Fonts.mediumBold
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        usernameLabel.font = Constants.Fonts.regular
        usernameLabel.textAlignment = .center
        usernameLabel.textColor = Constants.Colors.black
        
        leaguesLabel.font = Constants.Fonts.regular
        leaguesLabel.textAlignment = .center
        leaguesLabel.textColor = Constants.Colors.black
        
        eventsLabel.font = Constants.Fonts.regular
        eventsLabel.textAlignment = .center
        eventsLabel.textColor = Constants.Colors.black
        
        dismissImageView.image = UIImage(named: Constants.Vectors.backArrow)?.withRenderingMode(.alwaysTemplate)
        dismissImageView.contentMode = .center
        dismissImageView.tintColor = .white
        
        dividerView.backgroundColor = Constants.Colors.systemGray
        
        logoutLabel.text = "Logout"
        logoutLabel.textColor = Constants.Colors.red
        logoutLabel.font = Constants.Fonts.regular
        logoutLabel.textAlignment = .center
        
        logoImageView.image = UIImage(named: Constants.Icons.logoIcon)?.withRenderingMode(.alwaysTemplate)
        logoImageView.tintColor = Constants.Colors.lightBlue
    }
    
    override func setupGestureRecognizers() {
        dismissImageView.isUserInteractionEnabled = true
        let dismissTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedDismiss))
        dismissImageView.addGestureRecognizer(dismissTapGesture)
        
        logoutLabel.isUserInteractionEnabled = true
        let logoutTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedLogout))
        logoutLabel.addGestureRecognizer(logoutTapGesture)
    }
    
    @objc func clickedDismiss() {
        dismissClicked?()
    }
    
    @objc func clickedLogout() {
        logoutClicked?()
    }
    
    override func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(72)
            make.height.equalTo(28)
        }
        dismissImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(24)
        }
        userDataLabel.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalTo(25)
            make.leading.equalToSuperview().offset(16)
        }
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(userDataLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        leaguesLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        eventsLabel.snp.makeConstraints { make in
            make.top.equalTo(leaguesLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(eventsLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        aboutView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(216)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-64)
            make.height.equalTo(20)
        }
        logoutLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(logoImageView.snp.top).offset(-72)
        }
    }
    
    func set(username: String, leagueCount: Int, eventCount: Int) {
        usernameLabel.text = "Username: " + username
        leaguesLabel.text = "No. of leagues: \(leagueCount)"
        eventsLabel.text = "No. of events: \(eventCount)"
    }
}
