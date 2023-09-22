import Foundation
import UIKit

class BaseController: UIViewController {
    
    //MARK: - Public Property
    
    var tapPlus: (() -> Void)?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindBaseUI()
        setupBaseStyle()
    }
    
    private func bindBaseUI() {
        guard let tabBar = tabBarController as? TabBarController else { return }
        
        tabBar.flow = { [weak self] in
            guard let self = self else { return }
            self.tapPlus?()
        }
    }
    
    //MARK: - Private Method
    
    private func setupBaseStyle() {
        view.backgroundColor = ColorHelper.backgroundColor
        navigationController?.navigationBar.isHidden = true
        tabBarController?.navigationController?.navigationBar.isHidden = true
    }
}
