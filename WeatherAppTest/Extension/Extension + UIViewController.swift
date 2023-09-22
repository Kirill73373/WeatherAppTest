import Foundation
import UIKit

extension UIViewController {
    
    func alert(title: String, subTitle: String = "", ok: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            ok?()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}

