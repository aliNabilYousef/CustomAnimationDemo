//
//  FirstAnimationViewController.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/22/22.
//

import UIKit

class FirstAnimationViewController: LPViewController {
    
  //MARK: Class UI Eelements and basic functions
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    lazy private var collectionHeaderView = CustomHeaderView()
    
    lazy private var tableHeaderView = CustomHeaderView()
    
    var scrollInsetsHorizontally = 0.0
    var scrollInsetsVertically = 0.0
    
    enum SelectedScrollView {
        case table, collection
    }
    
    var selectedScrollView: SelectedScrollView = .table
    
    var hasFeaturedItems: Bool {
        return LPDataProvider.sharedInstance.dataSet.count > 0
    }
    
    override func setupUI() {
        super.setupUI()
        //this is supposed to check if there are elements in the carousel only but for this sake im keeping it as is
//        if hasFeaturedItems {
        setupCollectionViewHeader()
//        }
        setupCollectionView()
        setupTableViewHeader()
        setupTableView()
        setGradientBackground(.darkGray, .black)
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.frame = CGRect(x: 10, y: tableHeaderView.frame.origin.y + tableHeaderView.frame.height + 10, width: screenBounds.width - 20, height:screenBounds.height - (tableHeaderView.frame.origin.y + tableHeaderView.frame.height + 20))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }
    
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.frame = CGRect(x: 10, y: collectionHeaderView.frame.origin.y + collectionHeaderView.frame.height + 10, width: screenBounds.width - 20, height: 200)
        collectionHeaderView.headerDataModel = HeaderDataModel(headerTitle: "Featured")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupCollectionViewHeader() {
        collectionHeaderView.frame = CGRect(x: 10, y: backButton.frame.origin.y + backButton.frame.height + 20, width: screenBounds.width - 20, height: 25)
        self.view.addSubview(collectionHeaderView)
    }
    
    func setupTableViewHeader() {
        tableHeaderView.frame = CGRect(x: 10, y: collectionView.frame.origin.y + collectionView.frame.height + 20, width: collectionView.bounds.width, height: 25)
        tableHeaderView.headerDataModel = HeaderDataModel(headerTitle: "News")
        self.view.addSubview(tableHeaderView)
    }
}

//MARK: CollectionView Extension
extension FirstAnimationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LPDataProvider.sharedInstance.dataSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.dataModel = LPDataProvider.sharedInstance.dataSet[indexPath.row]
        cell.addShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let finalCellFrame = cell.frame
        let translation = collectionView.panGestureRecognizer.translation(in: collectionView.superview)
        
        if translation.x > 0 {
            cell.frame = CGRect(x: finalCellFrame.origin.x - 500, y: -500, width: 0, height: 0)
        } else {
            cell.frame = CGRect(x: finalCellFrame.origin.x + 500, y: 500, width: 0, height: 0)
        }
        cell.alpha = 0
        UIView.animate(withDuration: 0.6) {
            cell.alpha = 1
            cell.frame = finalCellFrame
        }
        (cell as? CustomCollectionViewCell)?.dataModel = LPDataProvider.sharedInstance.dataSet[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedScrollView = .collection
        let vc = DetailsScreen()
        vc.dataModel = LPDataProvider.sharedInstance.dataSet[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: TableView extension
extension FirstAnimationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return LPDataProvider.sharedInstance.dataSet.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! CustomTableViewCell
        cell.dataModel = LPDataProvider.sharedInstance.dataSet[indexPath.section]
        cell.imageView?.addShadow()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedScrollView = .table
        let vc = DetailsScreen()
        vc.dataModel = LPDataProvider.sharedInstance.dataSet[indexPath.section]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let translation = tableView.panGestureRecognizer.translation(in: tableView.superview)
        if translation.y < 0 {
            transitionAnimation(view: cell, animationOptions: .transitionCurlDown, isReset: true)
        } else {
            transitionAnimation(view: cell, animationOptions: .transitionCurlUp, isReset: true)
        }
    }
}

//MARK: Navigation controller transition extension
extension FirstAnimationViewController {
    override func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC is DetailsScreen {
            moveToTransition.transitionMode = .present
            return moveToTransition
        } else if toVC is ViewController {
            return foldTransition
        }
        return nil
    }
}

//MARK: TransitionProtocol implementation
extension FirstAnimationViewController: TransitionInfoProtocol {
    func viewsToAnimate() -> [UIView] {
        let cell: UIView?
        if selectedScrollView == .table, let indexPath = tableView.indexPathForSelectedRow {
            cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
            guard let imageView = (cell as? CustomTableViewCell)?.currentImageView,
                  let titleLabel = (cell as? CustomTableViewCell)?.titleLabel
            else {
                return []
            }
            return [titleLabel, imageView]
        }
        if selectedScrollView == .collection, let indexPath = collectionView.indexPathsForSelectedItems, indexPath.count > 0 {
            cell = collectionView.cellForItem(at: indexPath.first ?? IndexPath(item: 0, section: 0))// I know this is crash prone
            guard let imageView = (cell as? CustomCollectionViewCell)?.currentImageView,
                  let titleLabel = (cell as? CustomCollectionViewCell)?.titleLabel else {
                return []
            }
            return [titleLabel, imageView]
        }
        return []
    }
    
    func copyForView(_ subView: UIView) -> UIView {
        let cell: UIView?
        if selectedScrollView == .table, let indexPath = tableView.indexPathForSelectedRow {
            cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
            if subView == (cell as? CustomTableViewCell)?.titleLabel {
                let label = UILabel()
                label.text = (cell as? CustomTableViewCell)?.dataModel?.title
                label.textColor = .white
                label.font = UIFont.boldSystemFont(ofSize: 13)

                return label
            } else if subView == (cell as? CustomTableViewCell)?.currentImageView {
                let imageViewCopy = UIImageView(image: UIImage(named: (cell as? CustomTableViewCell)?.dataModel?.image ?? ""))
                imageViewCopy.contentMode = .scaleAspectFill
                imageViewCopy.clipsToBounds = true
                imageViewCopy.layer.cornerRadius = 10
                return imageViewCopy
            }
        } else if selectedScrollView == .collection, let indexPath = collectionView.indexPathsForSelectedItems, indexPath.count > 0 {
            cell = collectionView.cellForItem(at: indexPath.first ?? IndexPath(item: 0, section: 0))// Again I know this is crash prone
            if subView == (cell as? CustomCollectionViewCell)?.titleLabel {
                let label = UILabel()
                label.text = (cell as? CustomCollectionViewCell)?.dataModel?.title
                label.textColor = .white
                label.font = UIFont.boldSystemFont(ofSize: 13)
                return label
            } else if subView == (cell as? CustomCollectionViewCell)?.currentImageView {
                let imageViewCopy = UIImageView(image: UIImage(named: (cell as? CustomCollectionViewCell)?.dataModel?.image ?? ""))
                imageViewCopy.contentMode = .scaleAspectFill
                imageViewCopy.clipsToBounds = true
                imageViewCopy.layer.cornerRadius = 10
                return imageViewCopy
            }
        }
        return UIView()
    }
}
