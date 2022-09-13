//
//  UIView+Extension.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/22/22.
//

import UIKit

extension UIView {
    func getAbsoluteCoordinates() -> CGPoint {
        var x = self.frame.origin.x
        var y = self.frame.origin.y
        var oldView = self
        
        while let superView = oldView.superview {
            x += superView.frame.origin.x
            y += superView.frame.origin.y
            if superView.next is UIViewController {
                break //superView is the rootView of a UIViewController
            }
            oldView = superView
        }
        
        return CGPoint(x: x, y: y)
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 2)
        layer.shadowRadius = 2
    }
}
