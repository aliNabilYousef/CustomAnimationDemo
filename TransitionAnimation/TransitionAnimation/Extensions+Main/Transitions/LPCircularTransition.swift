//
//  LPCircularTransition.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/24/22.
//

import UIKit

enum TransitionMode {
    case present, dismiss, pop
}

class LPCircularTransition: NSObject {
    
    public var circle = UIView()
    public var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    var duration = 0.3
    var transitionMode: TransitionMode = .present
}

extension LPCircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: .to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.width / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {[weak self] in
                    self?.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }, completion: {success in
                    transitionContext.completeTransition(success)
                })
            }
        } else {
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.width / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {[weak self] in
                    guard let self = self else { return }
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: self.circle)
                    }
                }, completion: {[weak self] success in
                    returningView.center = viewCenter
                    self?.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
                
            }
        }
    }
    
    func frameForCircle(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = max(startPoint.x, viewSize.width - startPoint.x)
        let yLength = max(startPoint.y, viewSize.height - startPoint.y)
        
        let offsetVector = sqrt(pow(xLength, 2) + pow(yLength, 2)) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        return CGRect(origin: .zero, size: size)
    }
}
