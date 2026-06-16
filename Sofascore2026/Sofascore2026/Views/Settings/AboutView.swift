
import SofaAcademic
import UIKit
import SnapKit

class AboutView: BaseView {
    
    private let aboutLabel: UILabel = UILabel()
    private let academyLabel: UILabel = UILabel()
    private let yearLabel: UILabel = UILabel()
    private let appLabel: UILabel = UILabel()
    private let appNameLabel: UILabel = UILabel()
    private let developerLabel: UILabel = UILabel()
    private let developerNameLabel: UILabel = UILabel()
    
    private let dividerView: UIView = UIView()
    
    override func addViews() {
        addSubview(aboutLabel)
        addSubview(academyLabel)
        addSubview(yearLabel)
        addSubview(appLabel)
        addSubview(appNameLabel)
        addSubview(developerLabel)
        addSubview(developerNameLabel)
        addSubview(dividerView)
    }
    
    override func styleViews() {
        aboutLabel.text = "About"
        aboutLabel.font = Constants.Fonts.bold16
        aboutLabel.textColor = Constants.Colors.black
        
        academyLabel.text = "Sofascore iOS Academy"
        academyLabel.font = Constants.Fonts.bold
        academyLabel.textColor = Constants.Colors.black
        
        yearLabel.text = "Class 2026"
        yearLabel.font = Constants.Fonts.regular
        yearLabel.textColor = Constants.Colors.black
        
        appLabel.text = "App Name"
        appLabel.font = Constants.Fonts.smallBold
        appLabel.textColor = Constants.Colors.gray
        
        appNameLabel.text = "Mini Sofascore App"
        appNameLabel.font = Constants.Fonts.regular
        appNameLabel.textColor = Constants.Colors.black
        
        developerLabel.text = "Developer"
        developerLabel.font = Constants.Fonts.smallBold
        developerLabel.textColor = Constants.Colors.gray
        
        developerNameLabel.text = "Nino Salai"
        developerNameLabel.font = Constants.Fonts.regular
        developerNameLabel.textColor = Constants.Colors.black
        
        dividerView.backgroundColor = Constants.Colors.systemGray
    }
    
    override func setupConstraints() {
        aboutLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        academyLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(academyLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        appLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        developerLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        developerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(developerLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        dividerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
