
import SofaAcademic
import UIKit
import SnapKit

class DisplayHeaderView: BaseView {
    
    private let logoContainerView: UIView = UIView()
    private let logoImageView: UIImageView = UIImageView()
    
    private let tournamentLabel: UILabel = UILabel()
    private let countryLabel: UILabel = UILabel()
    
    private let backButtonView: UIView = UIView()
    private let backImageView: UIImageView = UIImageView()
    
    var onTappedBack: (() -> Void)?
    
    override func addViews() {
        addSubview(tournamentLabel)
        addSubview(countryLabel)
        
        addSubview(backButtonView)
        backButtonView.addSubview(backImageView)
        
        addSubview(logoContainerView)
        logoContainerView.addSubview(logoImageView)
    }
    
    override func styleViews() {
        backgroundColor = Constants.Colors.lightBlue
        
        backImageView.image = UIImage(named: Constants.Vectors.backArrow)?.withRenderingMode(.alwaysTemplate)
        backImageView.contentMode = .center
        backImageView.tintColor = .white
        
        logoContainerView.backgroundColor = .white
        logoContainerView.layer.cornerRadius = 8
        
        logoImageView.contentMode = .scaleAspectFit
        
        tournamentLabel.font = Constants.Fonts.mediumBold
        tournamentLabel.textColor = .white
        
        countryLabel.font = Constants.Fonts.bold
        countryLabel.textColor = .white
    }
    
    override func setupConstraints() {
        backButtonView.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.leading.equalToSuperview().offset(4)
            make.top.equalToSuperview()
        }
        backImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(16)
        }
        logoContainerView.snp.makeConstraints { make in
            make.size.equalTo(56)
            make.top.equalToSuperview().offset(48)
            make.leading.equalToSuperview().offset(16)
        }
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.leading.equalToSuperview().offset(8)
        }
        tournamentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.leading.equalToSuperview().offset(88)
            make.height.equalTo(28)
        }
        countryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(84)
            make.leading.equalToSuperview().offset(88)
            make.height.equalTo(16)
        }
    }
    
    override func setupGestureRecognizers() {
        backImageView.isUserInteractionEnabled = true
        let backTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedBack))
        backImageView.addGestureRecognizer(backTapGesture)
    }
    
    @objc func clickedBack() {
        onTappedBack?()
    }
    
    func set(league: League) {
        logoImageView.setUrlImage(logoUrl: league.logoUrl)
        tournamentLabel.text = league.name
        countryLabel.text = league.country?.name
    }
    func set(team: Team) {
        logoImageView.setUrlImage(logoUrl: team.logoUrl)
        tournamentLabel.text = team.name
        countryLabel.text = team.country?.name
    }
}
