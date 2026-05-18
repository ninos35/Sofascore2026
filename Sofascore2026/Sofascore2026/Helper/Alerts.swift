//
//  Alerts.swift
//  Sofascore2026
//
//  Created by akademija on 18.05.2026..
//

import UIKit

enum Alerts {
    
    static func showFetchError(on viewController: UIViewController) {
        
        let alert = UIAlertController(title: "Unable to load data",
                                      message: "Something went wrong",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
