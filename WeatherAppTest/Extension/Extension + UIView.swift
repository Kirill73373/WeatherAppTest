import Foundation
import SnapKit
import UIKit

extension UIView {
    
    func rotateDegrees(duration: CGFloat = 2) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = duration
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func removeDegrees() {
        self.layer.removeAnimation(forKey: "rotationAnimation")
    }
    
    func actionView(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        isUserInteractionEnabled = true
        
        let button = UIButton()
        button.backgroundColor = .clear
        button.removeFromSuperview()
        addSubview(button)
        
        button.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        button.addAction(UIAction { _ in
            UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.4)
            closure()
        }, for: controlEvents)
    }
}
