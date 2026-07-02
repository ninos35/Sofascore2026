
import SofaAcademic
import UIKit
import SnapKit

class IncidentView: BaseView {
    
    private let incidentImageView: UIImageView = UIImageView()
    
    private let minuteLabel: UILabel = UILabel()
    
    private let dividerView: UIView = UIView()
    
    private let playerLabel: UILabel = UILabel()
    
    private let scoreLabel: UILabel = UILabel()
    
    private let descriptionLabel: UILabel = UILabel()
    
    private let endPeriodView: UIView = UIView()
    private let endPeriodLabel: UILabel = UILabel()
    
    private let basketDividerView: UIView = UIView()
    
    override func addViews() {
        
        addSubview(incidentImageView)
        addSubview(minuteLabel)
        addSubview(dividerView)
        addSubview(playerLabel)
        addSubview(scoreLabel)
        addSubview(endPeriodView)
        addSubview(descriptionLabel)
        addSubview(basketDividerView)
        endPeriodView.addSubview(endPeriodLabel)
    }
    
    override func styleViews() {
        incidentImageView.image = UIImage(named: Constants.IncidentIcons.scoreIcon)
        incidentImageView.tintColor = .green
        incidentImageView.contentMode = .center
        
        minuteLabel.textColor = Constants.Colors.gray
        minuteLabel.font = Constants.Fonts.regularCondensed
        minuteLabel.textAlignment = .center
        
        dividerView.backgroundColor = Constants.Colors.lightGray
        basketDividerView.backgroundColor = Constants.Colors.lightGray
        
        playerLabel.textColor = Constants.Colors.black
        playerLabel.font = Constants.Fonts.regular
        playerLabel.textAlignment = .left
        
        descriptionLabel.textColor = Constants.Colors.gray
        descriptionLabel.font = Constants.Fonts.regularCondensed
        descriptionLabel.textAlignment = .left
        
        scoreLabel.textColor = Constants.Colors.black
        scoreLabel.textAlignment = .center
        scoreLabel.font = Constants.Fonts.mediumBold
        
        endPeriodLabel.backgroundColor = Constants.Colors.endPeriod
        endPeriodLabel.layer.cornerRadius = 16
        endPeriodLabel.clipsToBounds = true
        endPeriodLabel.font = Constants.Fonts.bold
        endPeriodLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        setupHomeIncidentConstraints()
    }
    
    func set(incident: Incident, sport: Sport) {
        playerLabel.text = incident.player
        
        if incident.isHomeTeam == false {
            playerLabel.textAlignment = .right
            descriptionLabel.textAlignment = .right
            setupAwayIncidentConstraints()
        } else {
            playerLabel.textAlignment = .left
            descriptionLabel.textAlignment = .left
            setupHomeIncidentConstraints()
        }
        
        minuteLabel.text = incident.minute.toString() + "'"
        
        switch incident.type {
        case .goal:
            scoreLabel.text = incident.score
            
            endPeriodView.isHidden = true
            incidentImageView.isHidden = false
            minuteLabel.isHidden = false
            dividerView.isHidden = false
            playerLabel.isHidden = false
            descriptionLabel.isHidden = true
            scoreLabel.isHidden = false
            basketDividerView.isHidden = true
            
            if sport == .basketball {
                if incident.scoreDiff == 1 {
                    incidentImageView.image = UIImage(named: Constants.IncidentIcons.scoreIcon)
                } else if incident.scoreDiff == 2 {
                    incidentImageView.image = UIImage(named: Constants.IncidentIcons.twoPointsIcon)
                } else if incident.scoreDiff == 3 {
                    incidentImageView.image = UIImage(named: Constants.IncidentIcons.threePointsIcon)
                }
                
                scoreLabel.font = Constants.Fonts.bold
                let home = incident.homeScore ?? 0
                let away = incident.awayScore ?? 0
                scoreLabel.text = "\(home) - \(away)"
                
                playerLabel.isHidden = true
                basketDividerView.isHidden = false
                
                setBasketballConstraints(isHomeTeam: incident.isHomeTeam ?? true)
            }
            
        case .redCard:
            incidentImageView.image = UIImage(named: Constants.IncidentIcons.yellowCard)?.withRenderingMode(.alwaysTemplate)
            incidentImageView.tintColor = Constants.Colors.red
            incidentImageView.backgroundColor = .clear
            
            endPeriodView.isHidden = true
            incidentImageView.isHidden = false
            minuteLabel.isHidden = false
            dividerView.isHidden = false
            playerLabel.isHidden = false
            descriptionLabel.isHidden = false
            scoreLabel.isHidden = true
            
            descriptionLabel.text = incident.description ?? "Argument"
            
            if incident.isHomeTeam == false {
                setupAwayIncidentConstraints()
                setAwayFoulConstraints()
            } else {
                setupHomeIncidentConstraints()
                setHomeFoulConstraints()
            }
            
        case .yellowCard:
            incidentImageView.image = UIImage(named: Constants.IncidentIcons.yellowCard)
            
            endPeriodView.isHidden = true
            incidentImageView.isHidden = false
            minuteLabel.isHidden = false
            dividerView.isHidden = false
            playerLabel.isHidden = false
            descriptionLabel.isHidden = false
            scoreLabel.isHidden = true
            
            descriptionLabel.text = incident.description ?? "Argument"
            
            if incident.isHomeTeam == false {
                setupAwayIncidentConstraints()
                setAwayFoulConstraints()
            } else {
                setupHomeIncidentConstraints()
                setHomeFoulConstraints()
            }
            
        case .periodEnd:
            endPeriodView.isHidden = false
            incidentImageView.isHidden = true
            minuteLabel.isHidden = true
            dividerView.isHidden = true
            playerLabel.isHidden = true
            scoreLabel.isHidden = true
            
            setEndPeriodConstraints()
            
            var text: String = incident.description ?? ""
            if incident.score != nil {
                text += " (\(incident.score ?? ""))"
            }
            endPeriodLabel.text = text
            
        case .foul:
            endPeriodView.isHidden = true
            incidentImageView.isHidden = false
            minuteLabel.isHidden = false
            dividerView.isHidden = false
            playerLabel.isHidden = false
            descriptionLabel.isHidden = false
            scoreLabel.isHidden = true
            
            descriptionLabel.text = incident.description ?? "Argument"
            
            if incident.isHomeTeam == false {
                setupAwayIncidentConstraints()
                setAwayFoulConstraints()
            } else {
                setupHomeIncidentConstraints()
                setHomeFoulConstraints()
            }
        }
    }
    
    func setupHomeIncidentConstraints() {
        incidentImageView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.height.width.equalTo(24)
        }
        minuteLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(32)
            make.height.equalTo(16)
            make.width.equalTo(40)
        }
        dividerView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(55)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(1)
        }
        scoreLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(64)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(28)
            make.width.equalTo(84)
        }
        playerLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(156)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(16)
            make.width.equalTo(188)
        }
    }
    
    func setupAwayIncidentConstraints() {
        incidentImageView.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
            make.height.width.equalTo(24)
        }
        minuteLabel.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(32)
            make.height.equalTo(16)
            make.width.equalTo(40)
        }
        dividerView.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-55)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(1)
        }
        scoreLabel.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-64)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(28)
            make.width.equalTo(84)
        }
        playerLabel.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-156)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(16)
            make.width.equalTo(188)
        }
    }
    
    func setEndPeriodConstraints() {
        endPeriodView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.edges.equalToSuperview()
        }
        endPeriodLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(24)
        }
    }
    
    func setHomeFoulConstraints() {
        playerLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(68)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(16)
            make.width.equalTo(276)
        }
        descriptionLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(68)
            make.top.equalToSuperview().offset(28)
            make.height.equalTo(16)
            make.width.equalTo(276)
        }
    }
    
    func setAwayFoulConstraints() {
        playerLabel.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-68)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(16)
            make.width.equalTo(276)
        }
        descriptionLabel.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-68)
            make.top.equalToSuperview().offset(28)
            make.height.equalTo(16)
            make.width.equalTo(276)
        }
    }
    
    func setBasketballConstraints(isHomeTeam: Bool) {
        minuteLabel.snp.remakeConstraints { make in
            make.top.equalTo(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(24)
        }
        basketDividerView.snp.remakeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalTo(24)
            make.centerX.equalToSuperview()
        }
        if isHomeTeam {
            incidentImageView.snp.remakeConstraints { make in
                make.width.height.equalTo(24)
                make.top.equalToSuperview().offset(8)
                make.leading.equalToSuperview().offset(16)
            }
            dividerView.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(55)
                make.top.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-8)
                make.width.equalTo(1)
            }
            scoreLabel.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(60)
                make.top.equalToSuperview().offset(12)
                make.height.equalTo(16)
                make.width.equalTo(80)
            }
        } else {
            incidentImageView.snp.remakeConstraints { make in
                make.width.height.equalTo(24)
                make.top.equalToSuperview().offset(8)
                make.trailing.equalToSuperview().offset(-16)
            }
            dividerView.snp.remakeConstraints { make in
                make.trailing.equalToSuperview().offset(-55)
                make.top.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-8)
                make.width.equalTo(1)
            }
            scoreLabel.snp.remakeConstraints { make in
                make.trailing.equalToSuperview().offset(-60)
                make.top.equalToSuperview().offset(12)
                make.height.equalTo(16)
                make.width.equalTo(80)
            }
        }
    }
}
