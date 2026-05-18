//
//  UIImageView+Ext.swift
//  Sofascore2026
//
//  Created by akademija on 10.05.2026..
//

import UIKit
import Kingfisher

extension UIImageView {
    func setUrlImage(logoUrl: String) {
        guard let url = URL(string: logoUrl) else { return }
        
        self.kf.setImage(with: url)
    }
}
