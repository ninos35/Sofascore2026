
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
        setData()
    }
    
    func addViews() {
        view.addSubview(settingsView)
    }
    
    func styleViews() {
        view.backgroundColor = Constants.Colors.lightBlue
    }
    
    func setupConstraints() {
        settingsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func gestureRecognisers() {
        settingsView.dismissClicked = { [weak self] in
            self?.handleDismiss()
        }
        settingsView.logoutClicked = { [weak self] in
            self?.handleLogout()
        }
    }
    
    func handleDismiss() {
        self.dismiss(animated: true)
    }
    
    func handleLogout() {
        KeychainManager.shared.deleteData()
        
        try? DatabaseManager.shared.clearAllData()
        
        let loginViewController: LoginViewController = LoginViewController()
        let navigationController: UINavigationController = UINavigationController(rootViewController: loginViewController)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navigationController
        }
    }
    
    func setData() {
        let username: String = KeychainManager.shared.getUsername() ?? "No Username"
        let leagueCount: Int = (try? DatabaseManager.shared.leagueCount()) ?? 0
        let eventCount: Int = (try? DatabaseManager.shared.eventCount()) ?? 0
        
        settingsView.set(username: username, leagueCount: leagueCount, eventCount: eventCount)
    }
}
