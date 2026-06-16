
import UIKit
import SnapKit

class PlayerCell: UITableViewCell {
    
    static let id: String = String(describing: PlayerCell.self)
    
    private let playerView: PlayerView = PlayerView()
    
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
        contentView.addSubview(playerView)
    }
    
    func setupConstraints() {
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with player: Player) {
        playerView.set(player: player)
    }
}
