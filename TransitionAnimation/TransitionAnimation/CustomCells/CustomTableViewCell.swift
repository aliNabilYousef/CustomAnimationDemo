//
//  CustomTableViewCell.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/23/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
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
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    var dataModel: BasicDataModel? {
        didSet {
            setupUI()
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI() {
        self.addSubview(currentImageView)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addShadow()
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        currentImageView.frame = CGRect(x: 10, y: 10, width: self.frame.width / 2 - 20, height: 130)
        titleLabel.frame = CGRect(x: currentImageView.frame.origin.x + currentImageView.frame.width + 10,
                                  y: 10,
                                  width: self.frame.width - currentImageView.frame.origin.x - currentImageView.frame.width - 10,
                                  height: 30)
        descriptionLabel.frame = CGRect(x: titleLabel.frame.origin.x,
                                        y: titleLabel.frame.origin.y + titleLabel.frame.height + 5,
                                        width: titleLabel.frame.width,
                                        height:  150 - titleLabel.frame.height - 20)
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        layer.cornerRadius = 10
        guard let dataModel = dataModel else { return }
        currentImageView.image = UIImage(named: dataModel.image)
        titleLabel.text = dataModel.title
        descriptionLabel.text = dataModel.description
    }
}
