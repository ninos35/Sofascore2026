
import SofaAcademic
import UIKit
import SnapKit

class StaffDetails: BaseView {
    
    private let teamView: UIView = UIView()
    private let teamInfoLabel: UILabel = UILabel()
    
    private let managerView: PlayerView = PlayerView()
    
    private let playersStackView: UIStackView = UIStackView()
    private let totalView: UIView = UIView()
    private let playersImageView: UIImageView = UIImageView()
    private let totalNumberLabel: UILabel = UILabel()
    private let totalLabel: UILabel = UILabel()
    
    private let foreignView: UIView = UIView()
    private let foreignNumberLabel: UILabel = UILabel()
    private let foreignLabel: UILabel = UILabel()
    private let chartView: ChartView = ChartView()
    
    override func addViews() {
        addSubview(teamView)
        addSubview(playersStackView)
        addSubview(managerView)
        
        teamView.addSubview(teamInfoLabel)
        
        playersStackView.addArrangedSubview(totalView)
        playersStackView.addArrangedSubview(foreignView)
        
        totalView.addSubview(playersImageView)
        totalView.addSubview(totalNumberLabel)
        totalView.addSubview(totalLabel)
        
        foreignView.addSubview(foreignNumberLabel)
        foreignView.addSubview(foreignLabel)
        foreignView.addSubview(chartView)
    }
    
    override func styleViews() {
        teamView.backgroundColor = .white
        teamInfoLabel.text = "Team Info"
        teamInfoLabel.font = Constants.Fonts.bold16
        teamInfoLabel.textColor = Constants.Colors.black
        teamInfoLabel.textAlignment = .center
        
        playersStackView.axis = .horizontal
        playersStackView.distribution = .fillEqually
        playersStackView.backgroundColor = .white
        
        playersImageView.image = UIImage(named: Constants.Icons.playersIcon)
        playersImageView.contentMode = .center
        
        totalNumberLabel.font = Constants.Fonts.bold
        totalNumberLabel.textColor = Constants.Colors.lightBlue
        totalNumberLabel.textAlignment = .center
        
        totalLabel.text = "Total Players"
        totalLabel.font = Constants.Fonts.regularCondensed
        totalLabel.textColor = Constants.Colors.gray
        totalLabel.textAlignment = .center
        
        foreignNumberLabel.font = Constants.Fonts.bold
        foreignNumberLabel.textColor = Constants.Colors.lightBlue
        foreignNumberLabel.textAlignment = .center
        
        foreignLabel.text = "Foreign Players"
        foreignLabel.font = Constants.Fonts.regularCondensed
        foreignLabel.textColor = Constants.Colors.gray
        foreignLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        teamView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        teamInfoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        managerView.snp.makeConstraints { make in
            make.top.equalTo(teamView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64)
        }
        playersStackView.snp.makeConstraints { make in
            make.top.equalTo(managerView.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(124)
        }
        totalView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        playersImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.size.equalTo(40)
            make.centerX.equalToSuperview()
        }
        totalNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
        }
        totalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(76)
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
        }
        foreignView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        chartView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.size.equalTo(40)
            make.centerX.equalToSuperview()
        }
        foreignNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
        }
        foreignLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(76)
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
        }
    }
    
    func set(teamInfo: TeamInfo) {
        managerView.set(manager: teamInfo.manager)
    }
    
    func set(totalPlayers: Int, foreignPlayers: Int) {
        totalNumberLabel.text = totalPlayers.toString()
        foreignNumberLabel.text = foreignPlayers.toString()
        
        chartView.set(totalPlayers: totalPlayers, foreignPlayers: foreignPlayers)
    }
}
