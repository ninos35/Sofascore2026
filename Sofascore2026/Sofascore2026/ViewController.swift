//
//  ViewController.swift
//  Sofascore2026
//
//  Created by akademija on 05.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {
    
    private let dataSource = Homework2DataSource()
    private let leagueView = LeagueView()
    
    private let matchView1 = MatchView()
    private let matchView2 = MatchView()
    private let matchView3 = MatchView()
    private let matchView4 = MatchView()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addViews()
        styleViews()
        setupConstraints()
        
        leagueView.set(league: dataSource.laLigaLeague())
        
        matchView1.set(event: dataSource.laLigaEvents()[0])
        matchView2.set(event: dataSource.laLigaEvents()[1])
        matchView3.set(event: dataSource.laLigaEvents()[2])
        matchView4.set(event: dataSource.laLigaEvents()[3])
    }
    
    func addViews(){
        view.addSubview(leagueView)
        view.addSubview(matchView1)
        view.addSubview(matchView2)
        view.addSubview(matchView3)
        view.addSubview(matchView4)
    }
    
    func styleViews(){
        view.backgroundColor = .white
    }
    
    func setupConstraints(){
        
        leagueView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        matchView1.snp.makeConstraints { make in
            make.top.equalTo(leagueView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        matchView2.snp.makeConstraints { make in
            make.top.equalTo(matchView1.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        matchView3.snp.makeConstraints { make in
            make.top.equalTo(matchView2.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        matchView4.snp.makeConstraints { make in
            make.top.equalTo(matchView3.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
}
