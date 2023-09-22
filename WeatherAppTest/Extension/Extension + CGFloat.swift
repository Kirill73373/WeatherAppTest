import Foundation
import UIKit

extension CGFloat {
    
    var horizontal: CGFloat {
        return (self / 375) * UIScreen.width
    }
    
    var vertical: CGFloat {
        return (self / 812) * UIScreen.height
    }
}
