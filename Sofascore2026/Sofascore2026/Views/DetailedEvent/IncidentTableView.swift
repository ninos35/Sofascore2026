
import SofaAcademic
import UIKit
import SnapKit

struct IncidentSection {
    let incidents: [Incident]
}

class IncidentTableView: BaseView {
    
    private var currentSport: Sport = .football
    
    private var sections: [IncidentSection] = []
    
    private let tableView: UITableView = .init()
    
    override func addViews() {
        addSubview(tableView)
    }
    
    override func styleViews() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 8
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = Constants.Colors.systemGray
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTableView(sport: Sport) {
        tableView.register(IncidentCell.self, forCellReuseIdentifier: IncidentCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        self.currentSport = sport
    }
    
    func set(sections: [IncidentSection]){
        self.sections = sections
        tableView.reloadData()
    }
}

extension IncidentTableView:  UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].incidents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let incident = sections[indexPath.section].incidents[indexPath.row]
        
        if incident.type == .periodEnd || currentSport == .basketball {
            return 40
        } else {
            return 56
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IncidentCell.id, for: indexPath) as? IncidentCell else {
            return UITableViewCell()
        }
        
        let incident: Incident = sections[indexPath.section].incidents[indexPath.row]
        
        cell.configure(with: incident, sport: currentSport)
        return cell
    }
}
