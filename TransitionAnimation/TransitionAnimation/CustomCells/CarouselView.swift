//
//  CarouselView.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/28/22.
//

import UIKit

protocol CarouselViewDelegate {
    func onOpenCarouselDetaisls(dataSet: CarouselProtocol)
}

class CarouselView: UIView {
    
    private lazy var currentInclination: CGFloat = CGFloat(dataSet?.dataSet.count ?? 1)

    var dataSet: CarouselProtocol?
    var delegate: CarouselViewDelegate?
    
    init(dataSet: CarouselProtocol, delegate: CarouselViewDelegate) {
        super.init(frame: .zero)
        self.dataSet = dataSet
        self.delegate = delegate
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        guard let dataSet = dataSet else { return }
        for item in dataSet.dataSet {
            createImage(name: item)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDetailsPage))
        addGestureRecognizer(tapGesture)
    }
    
    func createImage(name: String) {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: name)
        imageView.layer.cornerRadius = 10
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        addSubview(imageView)
        
        UIView.animate(withDuration: 1, animations: {[weak self] in
            imageView.transform = CGAffineTransform(rotationAngle: (.pi/2)/CGFloat((self?.dataSet?.dataSet.count ?? 1)) * (self?.currentInclination ?? 1))
        self?.currentInclination -= 1

        })
    }
    
    func degreeToRadians(deg: CGFloat) -> CGFloat {
        return (deg * CGFloat.pi)/180
    }
    
    @objc func openDetailsPage() {
        guard let dataSet = dataSet else { return }
        delegate?.onOpenCarouselDetaisls(dataSet: dataSet)
    }
}
