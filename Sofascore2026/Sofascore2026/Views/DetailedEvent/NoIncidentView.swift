
import SofaAcademic
import UIKit
import SnapKit

class NoIncidentView: BaseView {
    
    private let containerView: UIView = UIView()
    
    private let textLabel: UILabel = UILabel()
    
    private let detailsLabel: UILabel = UILabel()
    
    private var tournament: League?
    
    var showLeague: ((League) -> Void)?
    
    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(textLabel)
        containerView.addSubview(detailsLabel)
    }
    
    override func styleViews() {
        containerView.backgroundColor = .white
        
        textLabel.text = "No results yet."
        textLabel.textColor = Constants.Colors.gray
        textLabel.textAlignment = .center
        textLabel.font = Constants.Fonts.regular
        textLabel.backgroundColor = Constants.Colors.blueGray
        textLabel.layer.cornerRadius = 8
        textLabel.clipsToBounds = true
        
        detailsLabel.text = "View Tournament Details"
        detailsLabel.textColor = Constants.Colors.lightBlue
        detailsLabel.textAlignment = .center
        detailsLabel.font = Constants.Fonts.bold
        detailsLabel.layer.cornerRadius = 2
        detailsLabel.layer.borderWidth = 2
        detailsLabel.layer.borderColor = Constants.Colors.lightBlue.cgColor
        detailsLabel.clipsToBounds = true
    }
    
    override func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(148)
        }
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(52)
            make.width.equalTo(344)
            make.centerX.equalToSuperview()
        }
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(16)
            make.height.equalTo(40)
            make.width.equalTo(212)
            make.centerX.equalToSuperview()
        }
    }
    
    override func setupGestureRecognizers() {
        detailsLabel.isUserInteractionEnabled = true
        let detailsTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedDetails))
        detailsLabel.addGestureRecognizer(detailsTap)
    }
    
    @objc func clickedDetails() {
        if let tournament = tournament {
            showLeague?(tournament)
        }
    }
    
    func set(league: League) {
        self.tournament = league
    }
}
