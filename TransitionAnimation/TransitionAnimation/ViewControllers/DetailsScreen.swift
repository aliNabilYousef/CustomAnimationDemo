//
//  DetailsScreen.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/22/22.
//

import UIKit

class DetailsScreen: LPViewController {
    
    //MARK: Class UI Eelements and basic functions
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let descriptionLabel: LPLabel = {
        let label = LPLabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .natural
        return label
    }()
    
    var dataModel: BasicDataModel? {
        didSet {
            setupUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func setupUI() {
        super.setupUI()
        self.view.addSubview(titleLabel)
        self.view.addSubview(imageView)
        self.view.addSubview(descriptionLabel)
        titleLabel.frame = CGRect(x: 20, y: topSafeSpace + 60, width: screenBounds.width - 40, height: 30)
        imageView.frame = CGRect(x: 20, y: titleLabel.frame.origin.y + titleLabel.frame.height + 10, width: screenBounds.width - 40, height: 200)
        descriptionLabel.frame = CGRect(x: 20, y: imageView.frame.origin.y + imageView.frame.height + 10, width: screenBounds.width - 40, height: screenBounds.height - titleLabel.frame.height - imageView.frame.height - 40)
        descriptionLabel.sizeToFit()
        self.navigationController?.delegate = self
        
        guard let dataModel = dataModel else { return }
        let image = UIImage(named: dataModel.image)
        titleLabel.text = dataModel.title
        imageView.image = image
        descriptionLabel.text = dataModel.description
        setGradientBackground(.darkGray, .black)

        //This code takes the primary and secondary colors and sets them as the background color, but for the sake of performance i decided to comment this code
        //        DispatchQueue.main.async {[weak self] in
        //            let imageColors = image?.getColors()
        //            let primaryColor = imageColors?.primary
        //            let secondaryColor = imageColors?.secondary
        //            self?.setGradientBackground(secondaryColor ?? .white, primaryColor ?? .white)
        //            self?.backButton.setTitleColor(.white, for: .normal)
        //            self?.backButton.tintColor = .white
        //        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        descriptionLabel.animationType = .slideRightBounce
    }
}

//MARK: TransitionProtocol implementation
extension DetailsScreen: TransitionInfoProtocol {
    func viewsToAnimate() -> [UIView] {
        return [titleLabel, imageView]
    }
    
    func copyForView(_ subView: UIView) -> UIView {
        if subView == imageView {
            let imageViewCopy = UIImageView(image: imageView.image)
            imageViewCopy.contentMode = imageView.contentMode
            imageViewCopy.clipsToBounds = true
            imageViewCopy.contentMode = .scaleAspectFill
            imageViewCopy.layer.cornerRadius = 10
            return imageViewCopy
        } else if subView == titleLabel {
            let titleLabelCopy = UILabel(frame: titleLabel.frame)
            titleLabelCopy.clipsToBounds = true
            titleLabelCopy.textColor = .white
            titleLabelCopy.font = UIFont.boldSystemFont(ofSize: 16)
            return titleLabelCopy
        }
        return UIView()
    }
}

//MARK: Navigation controller transition extension
extension DetailsScreen {
    override func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        moveToTransition.transitionMode = .dismiss
        return moveToTransition
    }
}
