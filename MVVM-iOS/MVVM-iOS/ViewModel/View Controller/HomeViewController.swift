//
//  ViewController.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private let cellIdentifier = "MovieListCollectionViewCell"
    private let padding : CGFloat = 8.0
    private let movieLabelHeight : CGFloat = 25.0
    var viewModel : MovieViewModel!
    @IBOutlet weak var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel = MovieViewModel()
        viewModel.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.scrollDirection = .vertical
        flowLayout?.minimumLineSpacing = padding
        flowLayout?.minimumInteritemSpacing = padding
        flowLayout?.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        let cellWidth = (view.bounds.size.width - (padding * 3)) / 2 //( device width - padding between cell ) / 2
        let cellHeight = cellWidth + 25.0 // cell width + movie lable height
        flowLayout?.itemSize = CGSize(width: cellWidth , height: cellHeight)
    }

}

// MARK: - view model delegate methods
extension HomeViewController : ViewModelDelegate {
    func reloadTable(type: Int) {
        DispatchQueue.main.sync {
            self.collectionView.reloadItems(at:  [IndexPath(row: type, section: 0)])
        }
    }
}

// MARK: - Collection view delegate methods
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = viewModel.list[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieListCollectionViewCell
        cell.configureCell(cellData)
        return cell
    }
    
}

