import UIKit

final class TabBarController: UITabBarController {
    
    var tabBarHeight: CGFloat {
        customTabBar.preferredTabBarHeight
    }
    
    lazy var customTabBar: BaseCardTabBar = LightTabBar()
    
    fileprivate var tabBarHeightConstraint: NSLayoutConstraint?
    
    override var selectedIndex: Int {
        didSet {
            customTabBar.select(at: selectedIndex, animated: false, notifyDelegate: false)
        }
    }
    
    override var selectedViewController: UIViewController? {
        didSet {
            customTabBar.select(at: selectedIndex, animated: false, notifyDelegate: false)
        }
    }
    
    var flow: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        setupTabBar()
        updateTabBarHeightIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customTabBar.set(items: tabBar.items ?? [])
        customTabBar.select(at: selectedIndex, animated: false, notifyDelegate: true)
    }
    
    private func setupTabBar(){
        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight / 2.2, right: 0)
        customTabBar.delegate = self
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTabBar)
        customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        customTabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customTabBar.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        view.bringSubviewToFront(customTabBar)
    }
    
    private func updateTabBarHeightIfNeeded(){
        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight / 2.2, right: 0)
        tabBarHeightConstraint = customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight)
        tabBarHeightConstraint?.isActive = true
    }
    
    func setTabBarHidden(_ isHidden: Bool, animated: Bool) {
        let block = {
            self.customTabBar.alpha = isHidden ? 0 : 1
            self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: isHidden ? 0 : self.tabBarHeight, right: 0)
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: block, completion: nil)
        } else {
            block()
        }
    }
}

extension TabBarController: CardTabBarDelegate {
    
    func cardTabBar(_ sender: BaseCardTabBar, didSelectItemAt index: Int) {
        if index == 1 {
            flow?()
        } else {
            selectedIndex = index
        }
    }
    
    func didUpdateHeight() {
        updateTabBarHeightIfNeeded()
    }
}
