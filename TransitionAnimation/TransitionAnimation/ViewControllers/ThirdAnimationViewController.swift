//
//  ThirdAnimationViewController.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/24/22.
//

import UIKit

class ThirdAnimationViewController: LPViewController {
    
    //MARK: Class UI Eelements and basic functions
    private var holderView = LPHolderView(frame: .zero)
    
    private let closeButton: LPButton = {
        let button = LPButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("X", for: .normal)
        button.tintColor = .white
        button.isRounded = true
        return button
    }()
    
    private let animatedLabel: LPAnimatedLabel = {
        let label = LPAnimatedLabel()
        label.text = NSLocalizedString("Contents", comment: "")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.animationType = .wave
        label.placeHolderColor = .gray
        label.backgroundColor = .black
        label.textColor = . white
        return label
    }()
    
    private let DescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = NSLocalizedString("Animation Text", comment: "")
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let image = UIImage(named: "11")
    var fromButton: LPButton?
    var isCollapsedImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        self.backButton.removeFromSuperview()
        view.addSubview(closeButton)
        closeButton.frame = CGRect(x: screenBounds.width / 2 - 25, y: topSafeSpace + 20, width: 50, height: 50)
        closeButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        self.view.backgroundColor = .black
        
        view.addSubview(animatedLabel)
        view.backgroundColor = .black
        animatedLabel.frame = CGRect(x: 20, y: closeButton.frame.origin.y + closeButton.bounds.height + 20, width: UIScreen.main.bounds.size.width - 40, height: 50)
        animatedLabel.startAnimation(duration: 8.0, nil)
        
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 20, y: animatedLabel.frame.origin.y + animatedLabel.frame.height + 20, width: 200, height: 200)
        imageView.image = image
        
        view.addSubview(DescriptionLabel)
        DescriptionLabel.frame = CGRect(x: imageView.frame.origin.x + imageView.frame.width + 10,
                                        y: imageView.frame.origin.y,
                                        width: screenBounds.width - 20 - (imageView.frame.origin.x + imageView.frame.width),
                                        height: imageView.frame.height)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapText))
        DescriptionLabel.isUserInteractionEnabled = true
        DescriptionLabel.addGestureRecognizer(tap)
        
        let boxSize: CGFloat = 100.0
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
                                  y: imageView.frame.origin.y + imageView.frame.height + 40,
                                  width: boxSize,
                                  height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        view.addSubview(holderView)
        holderView.addOval()
    }
    
    @objc func didTapText() {
        if !isCollapsedImage {
            shrinkImageView()
        } else {
            expandImage()
        }
        isCollapsedImage = !isCollapsedImage
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true)
    }
    
    func shrinkImageView() {
        guard let image = image else { return }
        let sourceCGImage = image.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: CGRect(x: 0, y: 0, width: sourceCGImage.width/2, height: sourceCGImage.height)
        )!
        let croppedImage = UIImage(
            cgImage: croppedCGImage,
            scale: image.imageRendererFormat.scale,
            orientation: image.imageOrientation
        )
        
        let newImageView = UIImageView()
        newImageView.clipsToBounds = true
        newImageView.image = croppedImage
        newImageView.layer.cornerRadius = 5
        view.addSubview(newImageView)
        newImageView.frame = CGRect(origin: imageView.frame.origin, size: CGSize(width: imageView.frame.width / 2, height: imageView.frame.height))
        UIView.transition(with: imageView,
                          duration: animationDuration,
                          options: .curveEaseIn,
                          animations: {[weak self] in
            guard let self = self else { return }
            
            self.imageView.frame.size.width = self.imageView.frame.width  / 2
            self.DescriptionLabel.frame.origin.x = self.imageView.frame.origin.x + self.imageView.frame.width + 10
            self.DescriptionLabel.frame.size.width = self.screenBounds.width - 20 - (self.imageView.frame.origin.x + self.imageView.frame.width)
        }, completion:{[weak self] _ in
            self?.imageView.image = croppedImage
            newImageView.removeFromSuperview()
        })
    }
    
    func expandImage() {
        let newImageView = UIImageView()
        newImageView.clipsToBounds = true
        newImageView.layer.cornerRadius = 5
        newImageView.image = image
        imageView.removeFromSuperview()
        view.addSubview(newImageView)
        view.addSubview(imageView)
        newImageView.frame.origin = imageView.frame.origin
        newImageView.frame.size.height = imageView.frame.height
        UIView.transition(with: imageView,
                          duration: animationDuration,
                          options: .curveEaseIn,
                          animations: {[weak self] in
            guard let self = self else { return }
            newImageView.frame.size.width = self.imageView.frame.width * 2
            self.DescriptionLabel.frame.size.width = self.screenBounds.width - 20 - (newImageView.frame.origin.x + newImageView.frame.width)
            self.DescriptionLabel.frame.origin.x = newImageView.frame.origin.x + newImageView.frame.width + 10
        }, completion:{[weak self] _ in
            self?.imageView.image = self?.image
            self?.imageView.frame.size.width = (self?.imageView.frame.width ?? 0) * 2
            newImageView.removeFromSuperview()
        })
    }
}

//MARK: Holder view delegate extension
extension ThirdAnimationViewController: LPHolderViewDelegate {
    func concludeAnimation() {
        UIView.animate(withDuration: animationDuration, animations: {[weak self] in
            self?.holderView.alpha = 0
        }, completion: {[weak self] _ in
            self?.holderView.removeFromSuperview()
        })
    }
}
