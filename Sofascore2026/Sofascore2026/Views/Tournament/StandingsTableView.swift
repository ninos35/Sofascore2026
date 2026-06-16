
import SofaAcademic
import UIKit
import SnapKit

struct StandingSection {
    let standings: [Standings]
}

class StandingsTableView: BaseView {
    
    private var currentSport: Sport?
    
    private var sections: [StandingSection] = []
    
    private let tableView: UITableView = .init()
    
    var selectedTeam: ((Team) -> Void)?
    
    private let scrollView: UIScrollView = {
        let scroll: UIScrollView = UIScrollView()
        scroll.showsHorizontalScrollIndicator = true
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = false
        return scroll
    }()
    
    override func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(tableView)
    }
    
    override func styleViews() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.contentInset = .zero
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.equalTo(scrollView.frameLayoutGuide)
            make.width.equalToSuperview()
        }
    }
    
    func setBasketballConstraints() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.equalTo(scrollView.frameLayoutGuide)
            make.width.equalToSuperview().offset(50)
        }
    }
    
    func setupTableView(sport: Sport) {
        tableView.register(StandingRowCell.self, forCellReuseIdentifier: StandingRowCell.id)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "StandingsHeader")
        tableView.dataSource = self
        tableView.delegate = self
        self.currentSport = sport
        if sport == .basketball { setBasketballConstraints() }
    }
    
    func set(sections: [StandingSection]){
        self.sections = sections
        tableView.reloadData()
    }
}

extension StandingsTableView:  UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].standings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StandingsHeader")
        
        let rowView: StandingRowView
        
        if let existingRow = header?.contentView.subviews.first(where: { $0 is StandingRowView }) as? StandingRowView {
            rowView = existingRow
        } else {
            rowView = StandingRowView()
            header?.contentView.addSubview(rowView)
            rowView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        rowView.setHeader(sport: currentSport ?? .football)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected: Team = sections[indexPath.section].standings[indexPath.row].team
        selectedTeam?(selected)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StandingRowCell.id, for: indexPath) as? StandingRowCell else {
            return UITableViewCell()
        }
        
        let standing: Standings = sections[indexPath.section].standings[indexPath.row]
        
        cell.configure(with: standing, sport: currentSport ?? .football)
        
        return cell
    }
}
