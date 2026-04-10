//
//  MatchCell.swift
//  Sofascore2026
//
//  Created by akademija on 21.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class MatchCell: UITableViewCell {
    
    static let id: String = "MatchCell"
    
    private let matchView: MatchView = MatchView()
    
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
        contentView.addSubview(matchView)
    }
    
    func setupConstraints() {
        matchView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with event: Event) {
        matchView.set(event: event)
    }
}
