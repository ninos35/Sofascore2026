
import SofaAcademic
import UIKit
import SnapKit

class TabView: BaseView {
    
    private let label: UILabel = UILabel()
    
    private let underlineView: UIView = UIView()
    
    var stateChanged: ((TabView) -> Void)?
    
    var type: Constants.Tabs?
    
    var isSelected: Bool = false {
        didSet {
            underlineView.backgroundColor = isSelected ? .white : Constants.Colors.lightBlue
            stateChanged?(self)
        }
    }
    
    override func addViews() {
        addSubview(label)
        addSubview(underlineView)
    }
    
    override func styleViews() {
        label.font = Constants.Fonts.regular
        label.textColor = .white
        label.textAlignment = .center
        
        underlineView.layer.cornerRadius = 2
        underlineView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    override func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        underlineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(4)
        }
    }
    
    override func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabClicked))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tabClicked() {
        isSelected = true
    }
    
    func set(tab: Constants.Tabs) {
        self.type = tab
        label.text = type?.title
    }
}
