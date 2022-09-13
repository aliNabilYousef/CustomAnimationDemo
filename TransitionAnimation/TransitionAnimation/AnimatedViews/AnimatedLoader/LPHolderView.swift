//
//  LPHolderView.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/25/22.
//

import UIKit

protocol LPHolderViewDelegate: AnyObject {
    func concludeAnimation()
}

class LPHolderView: UIView {
    
    let ovalLayer = LPOvalLayer()
    let triangleLayer = LPTriangleLayer()
    let redRectangleLayer = LPRectangleLayer()
    let grayRectangleLayer = LPRectangleLayer()
    let arcLayer = LPArcLayer()
    
    var parentFrame :CGRect = .zero
    weak var delegate: LPHolderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addOval() {
        layer.addSublayer(ovalLayer)
        ovalLayer.expand()
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(wobbleOval),
                             userInfo: nil, repeats: false)
    }
    
    @objc func wobbleOval() {
        ovalLayer.wobble()
        // 1
        layer.addSublayer(triangleLayer) // Add this line
        ovalLayer.wobble()
        
        // 2
        // Add the code below
        Timer.scheduledTimer(timeInterval: 0.9, target: self,
                             selector: #selector(drawAnimatedTriangle), userInfo: nil,
                             repeats: false)
    }
    
    @objc func drawAnimatedTriangle() {
        triangleLayer.animate()
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(spinAndTransform),
                             userInfo: nil, repeats: false)
    }
    
    @objc func spinAndTransform() {
        // 1
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.6)
        
        // 2
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(Double.pi * 2.0)
        rotationAnimation.duration = 0.45
        rotationAnimation.isRemovedOnCompletion = true
        layer.add(rotationAnimation, forKey: nil)
        
        // 3
        ovalLayer.contract()
        
        Timer.scheduledTimer(timeInterval: 0.45, target: self,
                             selector: #selector(drawRedAnimatedRectangle),
                             userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 0.65, target: self,
                             selector: #selector(drawGrayAnimatedRectangle),
                             userInfo: nil, repeats: false)
    }
    
    @objc func drawRedAnimatedRectangle() {
        layer.addSublayer(redRectangleLayer)
        redRectangleLayer.animateStrokeWithColor(color: .red)
    }
    
    @objc func drawGrayAnimatedRectangle() {
        layer.addSublayer(grayRectangleLayer)
        grayRectangleLayer.animateStrokeWithColor(color: .darkGray)
        Timer.scheduledTimer(timeInterval: 0.40, target: self, selector: #selector(drawArc),
                             userInfo: nil, repeats: false)
    }
    
    @objc func drawArc() {
        layer.addSublayer(arcLayer)
        arcLayer.animate()
        Timer.scheduledTimer(timeInterval: 0.90, target: self, selector: #selector(expandView),
                             userInfo: nil, repeats: false)
    }
    
    @objc func expandView() {
        backgroundColor = UIColor.darkGray
        frame = CGRect(x: frame.origin.x - grayRectangleLayer.lineWidth,
                       y: frame.origin.y - grayRectangleLayer.lineWidth,
                       width: frame.size.width + grayRectangleLayer.lineWidth * 2,
                       height: frame.size.height + grayRectangleLayer.lineWidth * 2)
        layer.sublayers = nil
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.frame = self.parentFrame
        }, completion: { finished in
            self.exitAnimation()
        })
    }
    
    @objc func exitAnimation() {
        delegate?.concludeAnimation()
    }
    
}
