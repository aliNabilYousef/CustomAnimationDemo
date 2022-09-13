//
//  SecondAnimationViewController.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/22/22.
//

import UIKit

class SecondAnimationViewController: LPViewController {
    
    private(set) var dataSets: [CarouselProtocol] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Click an item 😉"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init(dataSets: [CarouselProtocol]) {
        super.init(nibName: nil, bundle: nil)
        self.dataSets = dataSets
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground(.darkGray, .black)
    }

    override func setupUI() {
        super.setupUI()
        view.addSubview(stackView)
        view.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 10, y: backButton.frame.origin.y + backButton.frame.height + 10, width: screenBounds.width - 40, height: 20)
        stackView.frame = CGRect(x: (screenBounds.width / 2) - 100, y: titleLabel.frame.origin.y + titleLabel.frame.height + 60, width: 200, height: screenBounds.height - titleLabel.frame.origin.y - titleLabel.frame.height - 60)
        for data in dataSets {
            let view = CarouselView(dataSet: data, delegate: self)
            view.frame = CGRect(x: 0, y: 15, width: stackView.frame.width, height: stackView.frame.height/CGFloat(dataSets.count) - 10)
            stackView.addArrangedSubview(view)
        }
    }
}

extension SecondAnimationViewController: CarouselViewDelegate {
    func onOpenCarouselDetaisls(dataSet: CarouselProtocol) {
        let vc = CarouselDetailsViewController(dataSet: dataSet)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
