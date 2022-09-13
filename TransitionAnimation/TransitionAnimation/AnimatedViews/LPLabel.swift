//
//  LPLabel.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/22/22.
//

import Foundation
import UIKit

@IBDesignable

class LPLabel: UILabel, LPAnimatable {
    
    var animationType: AnimationType? {
        didSet {
            animate()
        }
    }
    
    func animate() {
        switch animationType {
        case .downwardBounceDrop:
            self.alpha = 0
            self.center.y -= 100
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.alpha = 1
                self.center.y += 100
            })
        case .slideLeftBounce:
            self.alpha = 0
            self.center.x += 100
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.alpha = 1
                self.center.x -= 100
            })
        case .slideRightBounce:
            self.alpha = 0
            self.center.x -= 100
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.alpha = 1
                self.center.x += 100
            })
        case .slideAway:
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.alpha = 0
                self.center.x -= 200
            })
        default:
            return
        }
    }
}
