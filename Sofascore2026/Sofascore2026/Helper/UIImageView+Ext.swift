
import UIKit
import Kingfisher

extension UIImageView {
    func setUrlImage(logoUrl: String) {
        guard let url = URL(string: logoUrl) else { return }
        
        self.kf.setImage(with: url)
    }
}
