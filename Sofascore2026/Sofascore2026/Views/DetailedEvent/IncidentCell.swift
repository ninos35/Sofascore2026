
import UIKit
import SnapKit
import SofaAcademic

class IncidentCell: UITableViewCell {
    
    static let id: String = String(describing: IncidentCell.self)
    
    private let incidentView: IncidentView = IncidentView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func set() {
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        contentView.addSubview(incidentView)
    }
    
    func setupConstraints() {
        incidentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with incident: Incident, sport: Sport) {
        incidentView.set(incident: incident, sport: sport)
    }
}
