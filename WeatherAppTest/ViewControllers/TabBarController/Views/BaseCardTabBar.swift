import UIKit

protocol CardTabBarDelegate: AnyObject {
    func cardTabBar(_ sender: BaseCardTabBar, didSelectItemAt index: Int)
    func didUpdateHeight()
}

class BaseCardTabBar: UIView {
    
    var preferredTabBarHeight: CGFloat {
        return 70
    }
    
    var preferredBottomBackground: UIColor {
        return .clear
    }
    
    weak var delegate: CardTabBarDelegate?
    
    func select(at index: Int, animated: Bool, notifyDelegate: Bool) {
    }
    
    func set(items: [UITabBarItem]) {
    }
}
