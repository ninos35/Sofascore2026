
import UIKit

enum Alerts {
    
    static func showFetchError(on viewController: UIViewController) {
        
        let alert: UIAlertController = UIAlertController(title: "Unable to load data or there is no data",
                                                         message: "Something went wrong",
                                                         preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showLoginError(on viewController: UIViewController) {
        
        let alert: UIAlertController = UIAlertController(title: "Could not login",
                                                         message: "Incorrect data",
                                                         preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
