
import SofaAcademic
import UIKit
import SnapKit

struct PlayersSection {
    let players: [Player]
}

class PlayersTableView: BaseView {
    
    private var sections: [PlayersSection] = []
    
    private let tableView: UITableView = .init()
    
    var selectedTeam: ((Team) -> Void)?
    
    override func addViews() {
        addSubview(tableView)
    }
    
    override func styleViews() {
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Constants.Colors.systemGray
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.contentInset = .zero
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.backgroundColor = Constants.Colors.systemGray
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTableView() {
        tableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        
        setupHeader()
    }
    
    func set(players: [PlayersSection]){
        self.sections = players
        tableView.reloadData()
    }
    
    private func setupHeader() {
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        headerView.backgroundColor = .white
        
        let headerLabel: UILabel = UILabel(frame: CGRect(x: 16, y: 24, width: 41, height: 16))
        headerLabel.text = "Players"
        headerLabel.font = Constants.Fonts.smallBold
        headerLabel.textColor = Constants.Colors.black
        
        headerView.addSubview(headerLabel)
        tableView.tableHeaderView = headerView
    }
}

extension PlayersTableView:  UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].players.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.id, for: indexPath) as? PlayerCell else {
            return UITableViewCell()
        }
        
        let player: Player = sections[indexPath.section].players[indexPath.row]
        
        cell.configure(with: player)
        
        return cell
    }
}
