//
//  TransitionFromViewControllerDelegate.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/23/22.
//

import Foundation
import UIKit

class TransitionFromViewControllerDelegate: LPViewController {
    var originalView: UIView?
    var currentViewFrame : CGRect?
    var absuluteViewFrame: CGRect?
    
    func animateImageTransitionIn(originalView: UIView?, secondView: UIView?) {
        self.originalView = originalView
        secondView?.frame = absuluteViewFrame ?? .zero
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            secondView?.frame = self?.currentViewFrame ?? .zero
        })
    }
    
    func animateImageTransitionOutAndDismiss(originalView: UIView?, secondView: UIView?) {
        UIView.animate(withDuration: 0.4, animations: {[weak self] in
            secondView?.frame = self?.absuluteViewFrame ?? .zero
            self?.view.alpha = 0
        }, completion: {[weak self] _ in
            self?.dismiss(animated: false)
        })
    }
}
