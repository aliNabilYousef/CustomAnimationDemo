//
//  CustomCollectionViewCell.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/22/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    let currentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    
    var dataModel: BasicDataModel? {
        didSet {
            setupUI()
        }
    }
    
    func setupUI() {
        self.addSubview(currentImageView)
        self.addSubview(titleLabel)
        currentImageView.frame = CGRect(x: 10, y: 10, width: self.frame.width - 20, height: self.frame.height - 60)
        titleLabel.frame = CGRect(x: 10,
                                  y: currentImageView.frame.origin.y + currentImageView.frame.height + 5,
                                  width: self.frame.width - 20,
                                  height: 30)
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        layer.cornerRadius = 10
        guard let dataModel = dataModel else { return }
        currentImageView.image = UIImage(named: dataModel.image)
        titleLabel.text = dataModel.title
    }
}
