//
//  CustomHeaderView.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/27/22.
//

import UIKit

class CustomHeaderView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.clipsToBounds = true
        return label
    }()
    
    var headerDataModel: HeaderDataModel? {
        didSet {
            setupUI()
        }
    }

    func setupUI() {
        addSubview(titleLabel)
        titleLabel.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        backgroundColor = .clear
        guard let headerDataModel = headerDataModel else { return }
        titleLabel.text = headerDataModel.headerTitle
    }
}
