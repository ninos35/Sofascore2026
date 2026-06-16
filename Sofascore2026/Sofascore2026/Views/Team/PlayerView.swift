
import SofaAcademic
import UIKit
import SnapKit

class PlayerView: BaseView {
    
    private let nameLabel: UILabel = UILabel()
    private let countryLabel: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    
    override func addViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(countryLabel)
    }
    
    override func styleViews() {
        backgroundColor = .white
        
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = Constants.Colors.lightBlack.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        nameLabel.font = Constants.Fonts.regular
        nameLabel.textColor = Constants.Colors.black
        
        countryLabel.font = Constants.Fonts.smallBold
        countryLabel.textColor = Constants.Colors.gray
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(72)
        }
        countryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(72)
        }
    }
    
    func set(manager: TeamManager?) {
        
        guard let manager = manager else {
            nameLabel.text = "No Manager Available"
            return
        }
        
        nameLabel.text = manager.name
        countryLabel.text = manager.country?.name
        imageView.setUrlImage(logoUrl: manager.imageUrl)
    }
    
    func set(player: Player) {
        nameLabel.text = player.name
        countryLabel.text = player.country?.name
        imageView.setUrlImage(logoUrl: player.imageUrl)
    }
}
