import Foundation
import UIKit

extension Int {
    
    var horizontal: CGFloat {
        return (CGFloat(self) / 375) * UIScreen.width
    }
    
    var vertical: CGFloat {
        return (CGFloat(self) / 812) * UIScreen.height
    }
}
