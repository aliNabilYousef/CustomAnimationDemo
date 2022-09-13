//
//  LPTileTransition.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/26/22.
//

import UIKit

class LPTileTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval = 1.5
    
    var transitionMode: TransitionMode = .present
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        
        let bounds = containerView.bounds
        containerView.addSubview(toView)
        toView.frame = bounds
        
        let width = fromView.frame.width/2
        let height = (fromView.frame.height - fromView.safeAreaInsets.top)/2
        let topLeftFrame = CGRect(x: 0, y: 0, width: width, height: height)
        let topRightFrame = CGRect(x: width, y: 0, width: width, height: height)
        let bottomLeftFrame = CGRect(x: 0, y: height, width: width, height: height)
        let bottomRightFrame = CGRect(x: width, y: height, width: width, height: height)
        
        guard let topLeftView = fromView.resizableSnapshotView(from: topLeftFrame, afterScreenUpdates: false, withCapInsets: .zero),
              let topRightView = fromView.resizableSnapshotView(from: topRightFrame, afterScreenUpdates: false, withCapInsets: .zero),
              let bottomLeftView = fromView.resizableSnapshotView(from: bottomLeftFrame, afterScreenUpdates: false, withCapInsets: .zero),
              let bottomRightView = fromView.resizableSnapshotView(from: bottomRightFrame, afterScreenUpdates: false, withCapInsets: .zero) else {
            transitionContext.completeTransition(false)
            return
        }
        
        topLeftView.frame = topLeftFrame.offsetBy(dx: 0, dy: fromView.safeAreaInsets.top)
        topRightView.frame = topRightFrame.offsetBy(dx: 0, dy: fromView.safeAreaInsets.top)
        bottomLeftView.frame = bottomLeftFrame.offsetBy(dx: 0, dy: fromView.safeAreaInsets.top)
        bottomRightView.frame = bottomRightFrame.offsetBy(dx: 0, dy: fromView.safeAreaInsets.top)
        
        containerView.addSubview(bottomRightView)
        containerView.addSubview(bottomLeftView)
        containerView.addSubview(topRightView)
        containerView.addSubview(topLeftView)
        
        let animator0 = UIViewPropertyAnimator(duration: duration/4, curve: .easeOut) {
            topLeftView.frame.origin.x = width
        }
        
        let animator1 = UIViewPropertyAnimator(duration: duration/4, curve: .easeOut) {
            topLeftView.frame.origin.y = height + fromView.safeAreaInsets.top
        }
        
        animator0.addCompletion { position in
            topRightView.removeFromSuperview()
            animator1.startAnimation()
        }
        
        let animator2 = UIViewPropertyAnimator(duration: duration/4, curve: .easeOut) {
            topLeftView.frame.origin.x = 0
        }
        
        animator1.addCompletion { position in
            bottomRightView.removeFromSuperview()
            animator2.startAnimation()
        }
        
        let animator3 = UIViewPropertyAnimator(duration: duration/4, curve: .easeOut) {
            topLeftView.alpha = 0
            bottomLeftView.alpha = 0
        }
        
        animator2.addCompletion { position in
            bottomRightView.removeFromSuperview()
            animator3.startAnimation()
        }
        
        animator3.addCompletion { position in
            topLeftView.removeFromSuperview()
            topRightView.removeFromSuperview()
            bottomLeftView.removeFromSuperview()
            bottomRightView.removeFromSuperview()
            
            let finished = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(finished)
        }
        
        animator0.startAnimation()
    }
}
