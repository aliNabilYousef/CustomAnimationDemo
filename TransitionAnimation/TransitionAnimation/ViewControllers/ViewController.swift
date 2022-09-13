//
//  ViewController.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/22/22.
//

import UIKit

class ViewController: LPViewController {
    
    //MARK: Class UI Eelements and basic functions
    @IBOutlet weak var helloLabel: LPLabel!
    @IBOutlet weak var firstAnimationButton: LPButton!
    @IBOutlet weak var secondAnimationButton: LPButton!
    @IBOutlet weak var thirdAnimationButton: LPButton!
    
    lazy var circularTransition = LPCircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text = NSLocalizedString("Hello", comment: "")
        helloLabel.animationType = .downwardBounceDrop
        firstAnimationButton.animationType = .slideRightBounce
        secondAnimationButton.animationType = .slideLeftBounce
        
        thirdAnimationButton.backgroundColor = .black
        thirdAnimationButton.setTitleColor(.white, for: .normal)
        thirdAnimationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        thirdAnimationButton.isRounded = true
        thirdAnimationButton.animationType = .downwardBounceDrop
        
        thirdAnimationButton.layer.borderWidth = 0
        self.view.backgroundColor = .darkGray
        self.navigationController?.delegate = self
        self.backButton.removeFromSuperview()
        setGradientBackground(.darkGray, .black)
    }
    
    @IBAction func onFirstAnimationButtonPressed(_ sender: Any) {
        let vc = FirstAnimationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onSecondAnimationButtonPressed(_ sender: Any) {
        let vc = SecondAnimationViewController(dataSets: LPDataProvider.sharedInstance.dataStringsArray)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onThirdAnimationButtonPressed(_ sender: Any) {
        let vc = ThirdAnimationViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true)
    }
}

//MARK: Presentation controller transition extension
extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented is ThirdAnimationViewController {
            circularTransition.transitionMode = .present
            circularTransition.startingPoint = thirdAnimationButton.center
            circularTransition.circleColor = thirdAnimationButton.backgroundColor ?? .white
            return circularTransition
        }
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed is ThirdAnimationViewController {
            circularTransition.transitionMode = .dismiss
            circularTransition.startingPoint = thirdAnimationButton.center
            circularTransition.circleColor = thirdAnimationButton.backgroundColor ?? .white
            return circularTransition
        }
        return nil
    }
}
