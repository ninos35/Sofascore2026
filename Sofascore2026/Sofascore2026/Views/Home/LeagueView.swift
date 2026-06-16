
import SofaAcademic
import UIKit
import SnapKit

class LeagueView: BaseView {
    
    private let mainView: UIView = UIView()
    private let logoImageView: UIImageView = UIImageView()
    
    private let leagueStackView: UIStackView = UIStackView()
    
    private let countryLabel: UILabel = UILabel()
    private let arrowImageView: UIImageView = UIImageView()
    private let leagueLabel: UILabel = UILabel()
    
    var onLeagueClick: ((League) -> Void)?
    
    private var currentLeague: League?
    
    override func addViews() {
        addSubview(mainView)
        mainView.addSubview(logoImageView)
        mainView.addSubview(leagueStackView)
        
        leagueStackView.addArrangedSubview(countryLabel)
        leagueStackView.addArrangedSubview(arrowImageView)
        leagueStackView.addArrangedSubview(leagueLabel)
    }
    
    override func styleViews() {
        mainView.backgroundColor = .white
        
        countryLabel.font = Constants.Fonts.bold
        countryLabel.textColor = Constants.Colors.black
        
        arrowImageView.image = UIImage(named: Constants.Vectors.pointingVector)
        arrowImageView.contentMode = .scaleAspectFit
        
        leagueLabel.font = Constants.Fonts.bold
        leagueLabel.textColor = Constants.Colors.gray
        
        leagueStackView.spacing = 7
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        leagueStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    override func setupGestureRecognizers() {
        self.isUserInteractionEnabled = true
        let leagueTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leagueTapped))
        self.addGestureRecognizer(leagueTap)
    }
    
    @objc private func leagueTapped() {
        if let league = currentLeague {
            onLeagueClick?(league)
        }
    }
    
    func set(league: League){
        countryLabel.text = league.country?.name
        leagueLabel.text = league.name
        logoImageView.setUrlImage(logoUrl: league.logoUrl)
        currentLeague = league
    }
}
