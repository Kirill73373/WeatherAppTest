import Foundation
import UIKit

extension UIStackView {
    
    convenience init(ax: NSLayoutConstraint.Axis, alignm: UIStackView.Alignment, distr: UIStackView.Distribution) {
        self.init(frame: .zero)
        self.axis = ax
        self.alignment = alignm
        self.distribution = distr
        self.backgroundColor = .clear
    }
    
    @discardableResult func addingArrangedSubviews(_ arrangedSubviews: [UIView]) -> UIStackView {
        arrangedSubviews.forEach {
            self.addArrangedSubview($0)
        }
        return self
    }
    
    @discardableResult func addingArrangedSubview(_ arrangedSubview: UIView) -> UIStackView {
        self.addArrangedSubview(arrangedSubview)
        return self
    }
    
    @discardableResult func removeArrangedSubviews(view: UIView) -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(view)
            NSLayoutConstraint.deactivate(view.constraints)
            view.removeFromSuperview()
            return removedSubviews + [view]
        }
        return removedSubviews
    }
    
    @discardableResult func removeAllArrangedSubviews() -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }
}
