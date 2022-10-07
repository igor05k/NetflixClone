import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    static let identifier = String(describing: CollectionViewTableViewCell.self)
    
    private var titles: [MoviesAndTVShows] = [MoviesAndTVShows]()
    
    lazy var tvShowcollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TitlesCollectionViewCell.self, forCellWithReuseIdentifier: TitlesCollectionViewCell.identifier)
        
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tvShowcollectionView.delegate = self
        tvShowcollectionView.dataSource = self
        contentView.addSubview(tvShowcollectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tvShowcollectionView.frame = contentView.bounds
    }
    
    public func feedTitlesArray(with titles: [MoviesAndTVShows]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            if let self = self {
                self.tvShowcollectionView.reloadData()
            }
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitlesCollectionViewCell.identifier, for: indexPath) as? TitlesCollectionViewCell else { return UICollectionViewCell() }
        
        guard let titlesPoster = titles[indexPath.row].poster_path else { return UICollectionViewCell() }
                
        cell.configure(with: titlesPoster)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
}
