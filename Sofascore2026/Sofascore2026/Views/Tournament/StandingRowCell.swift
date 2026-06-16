
import UIKit
import SnapKit
import SofaAcademic

class StandingRowCell: UITableViewCell {
    
    static let id: String = String(describing: StandingRowCell.self)
    
    private let standingRowView: StandingRowView = StandingRowView()
    
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
        contentView.addSubview(standingRowView)
    }
    
    func setupConstraints() {
        standingRowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with standing: Standings, sport: Sport) {
        standingRowView.set(standings: standing, sport: sport)
    }
}
