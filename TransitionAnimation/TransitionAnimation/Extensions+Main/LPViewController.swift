//
//  LPViewController.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/22/22.
//

import UIKit

class LPViewController: UIViewController {
    
    //MARK: Class UI Eelements and basic functions
    let animationDuration = 0.3
    lazy var foldTransition = LPFoldTransition()
    lazy var moveToTransition = LPMoveElementsTransition()
    lazy var tileTransition = LPTileTransition()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward.to.line"), for: .normal)
        button.setTitle("back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var topSafeSpace: CGFloat{
        return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
    }
    
    var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    func degreeToRadians(deg: CGFloat) -> CGFloat {
        return (deg * CGFloat.pi)/180
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }
    
    func setupUI() {
        self.view.addSubview(backButton)
        backButton.frame = CGRect(x: 0, y: topSafeSpace + 20, width: 75, height: 30)
        backButton.addTarget(self, action: #selector(onBackButtonPressed), for: .touchUpInside)
    }
    
    @objc func onBackButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setGradientBackground(_ color1: UIColor, _ color2: UIColor) {
        let colorTop =  color1.cgColor
        let colorBottom = color2.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

//MARK: for animation
extension LPViewController {
    func transitionAnimation(view: UIView, animationOptions: UIView.AnimationOptions, isReset: Bool) {
        UIView.transition(with: view, duration: animationDuration * 2, options: animationOptions, animations: {
            view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }, completion: nil)
    }
}

//MARK: Navigation controller transition extension
extension LPViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is FirstAnimationViewController || toVC is FirstAnimationViewController {
            return foldTransition
        } else if fromVC is CarouselDetailsViewController || toVC is CarouselDetailsViewController {
            return tileTransition
        }
        return nil
    }
}


