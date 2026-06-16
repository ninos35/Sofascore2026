
import SofaAcademic
import UIKit
import SnapKit

class StandingRowView: BaseView {
    
    private let numLabel: UILabel = UILabel()
    private let teamLabel: UILabel = UILabel()
    
    private let matchesLabel: UILabel = UILabel()
    private let winsLabel: UILabel = UILabel()
    private let drawsLabel: UILabel = UILabel()
    private let lossesLabel: UILabel = UILabel()
    private let goalsLabel: UILabel = UILabel()
    private let diffLabel: UILabel = UILabel()
    private let strLabel: UILabel = UILabel()
    private let gbLabel: UILabel = UILabel()
    private let pctLabel: UILabel = UILabel()
    private let pointsLabel: UILabel = UILabel()
    
    private let dataStackView: UIStackView = UIStackView()
    
    private let circleView: UIView = UIView()
    
    override func addViews() {
        addSubview(teamLabel)
        addSubview(dataStackView)
        addSubview(circleView)
        
        circleView.addSubview(numLabel)
        
        dataStackView.addArrangedSubview(matchesLabel)
        dataStackView.addArrangedSubview(winsLabel)
        dataStackView.addArrangedSubview(drawsLabel)
        dataStackView.addArrangedSubview(lossesLabel)
        dataStackView.addArrangedSubview(goalsLabel)
        dataStackView.addArrangedSubview(diffLabel)
        dataStackView.addArrangedSubview(strLabel)
        dataStackView.addArrangedSubview(gbLabel)
        dataStackView.addArrangedSubview(pctLabel)
        dataStackView.addArrangedSubview(pointsLabel)
    }
    
    override func styleViews() {
        backgroundColor = Constants.Colors.systemGray
        
        dataStackView.arrangedSubviews.forEach { $0.isHidden = false }
        
        numLabel.font = Constants.Fonts.regular
        numLabel.textAlignment = .center
        teamLabel.font = Constants.Fonts.regular
        
        dataStackView.arrangedSubviews.compactMap { $0 as? UILabel }
            .forEach {
                $0.font = Constants.Fonts.regular
                $0.textAlignment = .center
            }
        
        dataStackView.axis = .horizontal
        dataStackView.spacing = 8
        
        circleView.backgroundColor = Constants.Colors.dirtyYellow
        circleView.layer.cornerRadius = 12
    }
    
    override func setupConstraints() {
        circleView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(8)
        }
        numLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(4)
            make.size.equalTo(16)
        }
        teamLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(128)
        }
        dataStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(16)
        }
        matchesLabel.snp.makeConstraints { make in make.width.equalTo(24) }
        winsLabel.snp.makeConstraints { make in make.width.equalTo(24) }
        drawsLabel.snp.makeConstraints { make in make.width.equalTo(24) }
        lossesLabel.snp.makeConstraints { make in make.width.equalTo(24) }
        goalsLabel.snp.makeConstraints { make in make.width.equalTo(40) }
        diffLabel.snp.makeConstraints { make in make.width.equalTo(32) }
        gbLabel.snp.makeConstraints { make in make.width.equalTo(40) }
        strLabel.snp.makeConstraints { make in make.width.equalTo(40) }
        pointsLabel.snp.makeConstraints { make in make.width.equalTo(32) }
        pctLabel.snp.makeConstraints { make in make.width.equalTo(40) }
    }
    
    func setHeader(sport: Sport) {
        
        circleView.backgroundColor = Constants.Colors.systemGray
        
        dataStackView.arrangedSubviews.forEach { subview in
            subview.isHidden = false
            
            if let label = subview as? UILabel {
                label.textColor = Constants.Colors.gray
            }
        }
        numLabel.text = "#"
        teamLabel.text = "Team"
        
        numLabel.textColor = Constants.Colors.gray
        teamLabel.textColor = Constants.Colors.gray
        
        switch sport {
        case .football:
            pctLabel.isHidden = true
            diffLabel.isHidden = true
            gbLabel.isHidden = true
            strLabel.isHidden = true
            
            matchesLabel.text = "P"
            winsLabel.text = "W"
            drawsLabel.text = "D"
            lossesLabel.text = "L"
            goalsLabel.text = "Goals"
            pointsLabel.text = "PTS"
            
        case .basketball:
            drawsLabel.isHidden = true
            goalsLabel.isHidden = true
            pointsLabel.isHidden = true
            
            matchesLabel.text = "M"
            winsLabel.text = "W"
            lossesLabel.text = "L"
            diffLabel.text = "DIFF"
            strLabel.text = "Str"
            gbLabel.text = "GB"
            pctLabel.text = "PCT"
            
        case .americanFootball:
            pointsLabel.isHidden = true
            diffLabel.isHidden = true
            goalsLabel.isHidden = true
            gbLabel.isHidden = true
            strLabel.isHidden = true
            
            matchesLabel.text = "P"
            winsLabel.text = "W"
            drawsLabel.text = "D"
            lossesLabel.text = "L"
            pctLabel.text = "PCT"
        }
    }
    
    func set(standings: Standings, sport: Sport) {
        
        dataStackView.arrangedSubviews.forEach { $0.isHidden = false }
        
        numLabel.text = standings.position.toString()
        teamLabel.text = standings.team.name
        
        switch sport {
        case .football:
            pctLabel.isHidden = true
            diffLabel.isHidden = true
            gbLabel.isHidden = true
            strLabel.isHidden = true
            
            matchesLabel.text = standings.matches.toString()
            winsLabel.text = standings.wins.toString()
            drawsLabel.text = standings.draws.toString()
            lossesLabel.text = standings.losses.toString()
            goalsLabel.text = "\(standings.scoreFor, default: ""):\(standings.scoreAgainst, default: "")"
            pointsLabel.text = standings.points?.toString()
            
        case .basketball:
            drawsLabel.isHidden = true
            goalsLabel.isHidden = true
            pointsLabel.isHidden = true
            
            matchesLabel.text = standings.matches.toString()
            winsLabel.text = standings.wins.toString()
            lossesLabel.text = standings.losses.toString()
            strLabel.text = standings.str ?? "0"
            if standings.gb == 0 {
                gbLabel.text = "-"
            } else {
                gbLabel.text = "\(standings.gb ?? 0)"
            }
            diffLabel.text = standings.scoreFormatted
            pctLabel.text = "\(standings.percentage, default: "0")"
            
        case .americanFootball:
            pointsLabel.isHidden = true
            diffLabel.isHidden = true
            goalsLabel.isHidden = true
            gbLabel.isHidden = true
            strLabel.isHidden = true
            
            matchesLabel.text = standings.matches.toString()
            winsLabel.text = standings.wins.toString()
            drawsLabel.text = standings.draws.toString()
            lossesLabel.text = standings.losses.toString()
            pctLabel.text = "\(standings.percentage, default: "")"
        }
    }
}
