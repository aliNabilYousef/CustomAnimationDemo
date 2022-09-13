//
//  CarouselDetailsViewController.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/28/22.
//

import UIKit

class CarouselDetailsViewController: LPViewController {
    
    private(set) var dataSet: CarouselProtocol? = nil
    
    //MARK: Class UI Eelements and basic functions
    private let titleLabel: LPLabel = {
        let label = LPLabel()
        label.numberOfLines = 0
        label.text = NSLocalizedString("Enjoy", comment: "")
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let transformLayer = CATransformLayer()
    private var currentAngle: CGFloat = 0.0
    private var currentOffset: CGFloat = 0.0
    
    init(dataSet: CarouselProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.dataSet = dataSet
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 20, y: topSafeSpace + 50, width: screenBounds.width - 40, height: 100)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(performPanAction(recognizer:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        self.view.backgroundColor = .darkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.animationType = .slideLeftBounce
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transformLayer.frame = self.view.bounds
        view.layer.addSublayer(transformLayer)
        for imageName in dataSet?.dataSet ?? [] {
            addImageCard(name: imageName)
        }
        turnCarousel()
    }
    
    func addImageCard(name: String) {
        let imageCardSize = CGSize(width: 150, height: 200)
        let imageLayer = CALayer()
        imageLayer.frame = CGRect(x: view.frame.size.width / 2 - imageCardSize.width / 2, y: view.frame.size.height / 2 - imageCardSize.height / 2, width: imageCardSize.width, height: imageCardSize.height)
        imageLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        guard let imageCardImage = UIImage(named: name)?.resize(withSize: CGSize(width: 150, height: 200))?.cgImage else { return }
        
        imageLayer.contents = imageCardImage
        imageLayer.contentsGravity = .resizeAspectFill
        imageLayer.masksToBounds = true
        imageLayer.isDoubleSided = true
        imageLayer.cornerRadius = 5
        imageLayer.borderWidth = 5
        imageLayer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        transformLayer.addSublayer(imageLayer)
    }
    
    func turnCarousel() {
        guard let transformSubLayers = transformLayer.sublayers else { return }
        let segmentForImageCard = CGFloat(360 / transformSubLayers.count) //360 => full circle
        var angleOffset = currentAngle
        for sublayer in transformSubLayers {
            var transform = CATransform3DIdentity
            transform.m34 = -1 / 500
            transform = CATransform3DRotate(transform, degreeToRadians(deg: angleOffset), 0, 1, 0)
            transform = CATransform3DTranslate(transform, 0, 0, 150)
            CATransaction.setAnimationDuration(0)
            sublayer.transform = transform
            angleOffset += segmentForImageCard
        }
    }
    
    @objc func performPanAction(recognizer: UIPanGestureRecognizer) {
        let xOffset = recognizer.translation(in: self.view).x
        
        if recognizer.state == .began {
            currentOffset = 0
        }
        
        let xDiff = xOffset / 2 - currentOffset
        currentOffset += xDiff
        currentAngle += xDiff
        turnCarousel()
    }
}
