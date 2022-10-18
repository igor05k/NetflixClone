//
//  TopSearchesResultsController.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 07/10/22.
//

import UIKit

protocol TopSearchesResultsControllerDelegate: AnyObject {
    func didTapTopSearchesResultsController(model: TitlePreviewModel)
}

class TopSearchesResultsController: UIViewController {
    weak var delegate: TopSearchesResultsControllerDelegate?
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
        
        guard let titleName = titles[indexPath.row].original_title ?? titles[indexPath.row].original_name else { return }
        guard let overview = titles[indexPath.row].overview else { return }
        
        APICaller.shared.youtubeSearch(with: titleName + " trailet") { [weak self] result in
            switch result {
            case .success(let videoElement):
                let model = TitlePreviewModel(titleName: titleName, videoInfo: videoElement, overview: overview)
                self?.delegate?.didTapTopSearchesResultsController(model: model)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
