
import SofaAcademic
import UIKit
import SnapKit

class TournamentsView: BaseView {
    
    private let tournamentsView: UIView = UIView()
    private let tournamentsLabel: UILabel = UILabel()
    private var leagues: [League] = []
    
    var onLeagueSelected: ((League) -> Void)?
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 96)
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LeagueCollectionViewCell.self, forCellWithReuseIdentifier: LeagueCollectionViewCell.id)
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        return collectionView
    }()
    private var collectionHeightConstraint: Constraint?
    
    override func addViews() {
        addSubview(tournamentsView)
        addSubview(collectionView)
        
        tournamentsView.addSubview(tournamentsLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let numberOfColumns: CGFloat = 3
        let cellWidth = bounds.width / numberOfColumns
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: cellWidth, height: 96)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
        }
    }
    
    override func styleViews() {
        backgroundColor = .white
        
        tournamentsView.backgroundColor = .white
        tournamentsLabel.text = "Tournaments"
        tournamentsLabel.font = Constants.Fonts.bold16
        tournamentsLabel.textColor = Constants.Colors.black
        
        collectionView.backgroundColor = .white
    }
    
    override func setupConstraints() {
        tournamentsView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        tournamentsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(tournamentsView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            collectionHeightConstraint = make.height.equalTo(96).constraint
        }
    }
    
    func set(tournaments leagues: [League]) {
        self.leagues = leagues
        
        let numberOfRows = ceil(Double(leagues.count) / 3.0)
        let height = Int(numberOfRows) * 96
        collectionHeightConstraint?.update(offset: height)
        
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

extension TournamentsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeagueCollectionViewCell.id, for: indexPath) as? LeagueCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: leagues[indexPath.item])
        return cell
    }
}

extension TournamentsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedLeague: League = leagues[indexPath.item]
        onLeagueSelected?(selectedLeague)
    }
}
