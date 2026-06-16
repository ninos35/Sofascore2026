
import UIKit

class ChartView: UIView {
    
    private let backgroundCircle = CAShapeLayer()
    private let foregroundCircle = CAShapeLayer()
    private var percentage: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundCircle.removeFromSuperlayer()
        foregroundCircle.removeFromSuperlayer()
        
        let center: CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius: CGFloat = bounds.width / 2 - 8
        let lineWidth: CGFloat = 6
        
        let circlePath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -.pi / 2,
            endAngle: .pi * 3 / 2,
            clockwise: true
        )
        
        backgroundCircle.path = circlePath.cgPath
        backgroundCircle.strokeColor = Constants.Colors.dirtyYellow.cgColor
        backgroundCircle.fillColor = UIColor.clear.cgColor
        backgroundCircle.lineWidth = lineWidth
        backgroundCircle.lineCap = .butt
        backgroundCircle.strokeEnd = 1
        layer.addSublayer(backgroundCircle)
        
        foregroundCircle.path = circlePath.cgPath
        foregroundCircle.strokeColor = Constants.Colors.lightBlue.cgColor
        foregroundCircle.fillColor = UIColor.clear.cgColor
        foregroundCircle.lineWidth = lineWidth
        foregroundCircle.lineCap = .butt
        foregroundCircle.strokeEnd = percentage
        layer.addSublayer(foregroundCircle)
    }
    
    func set(totalPlayers: Int, foreignPlayers: Int) {
        percentage = totalPlayers > 0 ? CGFloat(foreignPlayers) / CGFloat(totalPlayers) : 0
        setNeedsLayout()
    }
}
