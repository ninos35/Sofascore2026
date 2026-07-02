
import SofaAcademic
import UIKit
import SnapKit

class TeamDetailsView: BaseView {
    
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    
    private let staffDetails: StaffDetails = StaffDetails()
    private let tournamentsView: TournamentsView = TournamentsView()
    private let venueView: VenueView = VenueView()
    
    var onLeagueSelected: ((League) -> Void)?
    
    override func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(staffDetails)
        contentView.addSubview(tournamentsView)
        contentView.addSubview(venueView)
    }
    
    override func styleViews() {
        backgroundColor = Constants.Colors.systemGray
        scrollView.showsVerticalScrollIndicator = false
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        staffDetails.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(237)
        }
        tournamentsView.snp.makeConstraints { make in
            make.top.equalTo(staffDetails.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview()
        }
        venueView.snp.makeConstraints { make in
            make.top.equalTo(tournamentsView.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(88)
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupGestureRecognizers() {
        tournamentsView.onLeagueSelected = { [weak self] selectedLeague in
                self?.onLeagueSelected?(selectedLeague)
            }
    }
    
    func set(teamInfo: TeamInfo) {
        staffDetails.set(teamInfo: teamInfo)
    }
    
    func set(totalPlayers: Int, foreignPlayers: Int) {
        staffDetails.set(totalPlayers: totalPlayers, foreignPlayers: foreignPlayers)
    }
    
    func set(tournaments leagues: [League]) {
        tournamentsView.set(tournaments: leagues)
    }
    
    func set(venue: String) {
        venueView.set(venue: venue)
    }
}
