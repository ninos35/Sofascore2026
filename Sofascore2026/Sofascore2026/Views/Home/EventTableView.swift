
import SofaAcademic
import UIKit
import SnapKit

enum HeaderType {
    case league(League)
    case round(Int32)
}

struct Section {
    let header: HeaderType
    let events: [Event]
}

class EventTableView: BaseView {
    
    private var sections: [Section] = []
    
    private let tableView: UITableView = .init()
    
    var selectedEvent: ((Event) -> Void)?
    
    var selectedLeague: ((League) -> Void)?
    
    override func addViews() {
        addSubview(tableView)
    }
    
    override func styleViews() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 1
        tableView.backgroundColor = Constants.Colors.systemGray
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTableView() {
        tableView.register(LeagueCell.self, forHeaderFooterViewReuseIdentifier: LeagueCell.id)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "RoundHeader")
        tableView.register(MatchCell.self, forCellReuseIdentifier: MatchCell.id)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func set(sections: [Section]){
        self.sections = sections
        tableView.reloadData()
    }
}

extension EventTableView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].events.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionData: Section = sections[section]
        
        if case .round = sectionData.header {
            return 48
        } else {
            return 56
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionData: Section = sections[section]
        
        switch sectionData.header {
        case .league(let leagueData):
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: LeagueCell.id) as? LeagueCell else {
                return nil
            }
            header.configure(with: leagueData)
            
            header.onLeagueClick = { [weak self] clickedLeague in
                self?.selectedLeague?(clickedLeague)
            }
            
            return header
            
        case .round(let roundNumber):
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RoundHeader")
            
            let roundLabel: UILabel
            
            if let existingLabel = header?.contentView.subviews.first(where: { $0 is UILabel }) as? UILabel {
                roundLabel = existingLabel
            } else {
                roundLabel = UILabel()
                roundLabel.font = Constants.Fonts.smallBold
                
                header?.contentView.addSubview(roundLabel)
                
                roundLabel.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(24)
                    make.leading.equalToSuperview().offset(16)
                    make.height.equalTo(16)
                }
            }
            roundLabel.text = "Round \(roundNumber)"
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchCell.id, for: indexPath) as? MatchCell else {
            return UITableViewCell()
        }
        let match: Event = sections[indexPath.section].events[indexPath.row]
        cell.configure(with: match)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected: Event = sections[indexPath.section].events[indexPath.row]
        selectedEvent?(selected)
    }
}
