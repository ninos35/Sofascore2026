
import SofaAcademic
import UIKit
import SnapKit

class VenueView: BaseView {
    
    private let venueLabel: UILabel = UILabel()
    private let stadiumLabel: UILabel = UILabel()
    private let stadiumNameLabel: UILabel = UILabel()
    
    override func addViews() {
        addSubview(venueLabel)
        addSubview(stadiumLabel)
        addSubview(stadiumNameLabel)
    }
    
    override func styleViews() {
        backgroundColor = .white
        
        venueLabel.text = "Venue"
        venueLabel.font = Constants.Fonts.bold16
        venueLabel.textColor = Constants.Colors.black
        venueLabel.textAlignment = .center
        
        stadiumLabel.text = "Stadium"
        stadiumLabel.font = Constants.Fonts.regular
        stadiumLabel.textColor = Constants.Colors.black
        stadiumLabel.textAlignment = .center
        
        stadiumNameLabel.font = Constants.Fonts.regular
        stadiumNameLabel.textColor = Constants.Colors.black
        stadiumNameLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        venueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        stadiumLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.leading.equalToSuperview().offset(16)
        }
        stadiumNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func set(venue: String) {
        stadiumNameLabel.text = venue
    }
}
