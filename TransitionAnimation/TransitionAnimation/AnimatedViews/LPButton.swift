//
//  LPButton.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/22/22.
//

import UIKit

@IBDesignable

class LPButton: UIButton, LPAnimatable {
    var animationType: AnimationType? {
        didSet {
            animate()
        }
    }
    
    var isRounded: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.borderColor = UIColor(white: 1, alpha: 0.5).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = isRounded ? self.frame.width / 2 : 5
    }
    
    func animate() {
        switch animationType {
        case .slideRightBounce:
            self.alpha = 0
            self.center.x -= 100
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.alpha = 1
                self.center.x += 100
            })
        case .slideLeftBounce:
            self.alpha = 0
            self.center.x += 100
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.alpha = 1
                self.center.x -= 100
            })
        case .downwardBounceDrop:
            self.alpha = 0
            self.center.y -= 100
            UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.alpha = 1
                self.center.y += 100
            })
        default:
            return
        }
    }
}
