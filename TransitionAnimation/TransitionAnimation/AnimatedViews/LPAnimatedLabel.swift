//
//  LPAnimatedLabel.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/24/22.
//

import UIKit

public enum LPAnimationType {
    case none
    case typewriter
    case shine
    case fade
    case wave
}

open class LPAnimatedLabel: UILabel {
    
    // MARK: - Public Propertis
    open var animationType = LPAnimationType.none {
        didSet {
            _animator = LPDWAnimator(animationType: animationType, duration: _duration)
            _animator?.label = self
        }
    }
    open override var text: String? {
        didSet {
            _animator?.label = self
        }
    }
    open var placeHolderColor: UIColor?
    
    // MARK: - Private Properties
    private(set) var placeHolderView: UIView?
    private(set) var _duration: TimeInterval = 4.0
    private var _hollowLabel: LPDWMainLabel?
    private var _animator: LPDWAnimator?
    
    open func startAnimation(duration: TimeInterval, nextText: String? = nil,_ completion:(() -> Void)?) {
        guard let animator = _animator else {
            return
        }
        if text == nil && nextText == nil {
            return
        } else if nextText != nil {
            text = nextText
        }
        if animationType == .wave {
            placeHolderView = UIView(frame: bounds)
            placeHolderView?.backgroundColor = placeHolderColor ?? .lightGray
            placeHolderView?.layer.masksToBounds = true
            addSubview(placeHolderView!)
            
            _hollowLabel = LPDWMainLabel(frame: bounds)
            _hollowLabel?.text = text
            _hollowLabel?.textAlignment = textAlignment
            _hollowLabel?.font = font
            _hollowLabel?.fillColor = backgroundColor ?? .white
            addSubview(_hollowLabel!)
        }
        
        _duration = duration
        animator.duration = duration
        animator.label = self
        animator.startAnimation(completion)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class LPDWMainLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textColor = .white
    }
    
    public var fillColor = UIColor.white
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect)
        let context = UIGraphicsGetCurrentContext()
        defer {
            context?.restoreGState()
        }
        guard let image = context?.makeImage() else {
            return
        }
        guard let dataProvider = image.dataProvider,
              let imageMask = CGImage(maskWidth: image.width,
                                      height: image.height,
                                      bitsPerComponent: image.bitsPerComponent,
                                      bitsPerPixel: image.bitsPerPixel,
                                      bytesPerRow: image.bytesPerRow,
                                      provider: dataProvider,
                                      decode: image.decode,
                                      shouldInterpolate: true) else {
            return
        }
        
        context?.saveGState()
        context?.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: rect.height))
        context?.clear(rect)
        context?.clip(to: rect, mask: imageMask)
        context?.setFillColor(fillColor.cgColor)
        context?.fill(bounds)
    }
}
