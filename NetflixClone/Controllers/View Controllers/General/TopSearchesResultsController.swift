//
//  TopSearchesResultsController.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 07/10/22.
//

import UIKit

class TopSearchesResultsController: UIViewController {
    public var titles: [MoviesAndTVShows] = [MoviesAndTVShows]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TitlesCollectionViewCell.self, forCellWithReuseIdentifier: TitlesCollectionViewCell.identifier)
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}


extension TopSearchesResultsController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: TitlesCollectionViewCell.identifier, for: indexPath) as? TitlesCollectionViewCell else { return UICollectionViewCell() }
        
        if let titlesPoster = titles[indexPath.row].poster_path {
            collectionCell.configure(with: titlesPoster)
        }
        
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
