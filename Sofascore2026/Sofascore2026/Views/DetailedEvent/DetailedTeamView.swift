
import SofaAcademic
import UIKit
import SnapKit

class DetailedTeamView: BaseView {
    
    private let teamLogoImageView: UIImageView = UIImageView()
    private let teamNameLabel: UILabel = UILabel()
    
    private var team: Team?
    
    var selectedTeam: ((Team) -> Void)?
    
    override func addViews() {
        addSubview(teamLogoImageView)
        addSubview(teamNameLabel)
    }
    
    override func styleViews() {
        teamNameLabel.textAlignment = .center
        teamNameLabel.numberOfLines = 2
        teamNameLabel.font = Constants.Fonts.bold
    }
    
    override func setupConstraints() {
        teamLogoImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        teamNameLabel.snp.makeConstraints { make in
            make.top.equalTo(teamLogoImageView.snp.bottom).offset(8)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func setupGestureRecognizers() {
        self.isUserInteractionEnabled = true
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedTeam))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func clickedTeam() {
        if let clicked = team {
            selectedTeam?(clicked)
        }
    }
    
    func set(team: Team) {
        teamLogoImageView.setUrlImage(logoUrl: team.logoUrl)
        teamNameLabel.text = team.name
        self.team = team
    }
}
