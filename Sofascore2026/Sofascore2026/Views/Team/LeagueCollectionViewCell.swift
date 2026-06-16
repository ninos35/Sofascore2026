
import UIKit
import SnapKit

class LeagueCollectionViewCell: UICollectionViewCell {
    
    static let id: String = String(describing: LeagueCollectionViewCell.self)
    
    private let leagueImageView: UIImageView = UIImageView()
    private let leagueLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func set() {
        addViews()
        styleViews()
        setupConstraints()
    }
    
    func addViews() {
        contentView.addSubview(leagueImageView)
        contentView.addSubview(leagueLabel)
    }
    
    func styleViews() {
        backgroundColor = .white
        
        leagueLabel.font = Constants.Fonts.regularCondensed
        leagueLabel.textColor = Constants.Colors.gray
        leagueLabel.textAlignment = .center
        leagueLabel.numberOfLines = 2
    }
    
    func setupConstraints() {
        leagueImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
        leagueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.height.equalTo(32)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    func configure(with league: League) {
        leagueImageView.setUrlImage(logoUrl: league.logoUrl)
        leagueLabel.text = league.name
    }
}
