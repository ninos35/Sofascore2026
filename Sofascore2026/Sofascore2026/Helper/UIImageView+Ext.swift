//
//  UIImageView+Ext.swift
//  Sofascore2026
//
//  Created by akademija on 10.05.2026..
//

import UIKit

extension UIImageView {
    func setUrlImage(logoUrl: String) {
        guard let url = URL(string: logoUrl) else {return}
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
