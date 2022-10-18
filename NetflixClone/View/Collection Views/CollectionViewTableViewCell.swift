import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func didTapCollectionViewTableViewCell(_ cell: UITableViewCell, model: TitlePreviewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    static let identifier = String(describing: CollectionViewTableViewCell.self)
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private var titles: [MoviesAndTVShows] = [MoviesAndTVShows]()
    
    lazy var tvShowcollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 220)
        
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
        
        if let titlesPoster = titles[indexPath.row].poster_path ?? titles[indexPath.row].backdrop_path {
            cell.configure(with: titlesPoster)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    
        if let titleName = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title {
            APICaller.shared.youtubeSearch(with: titleName + " trailer") { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let videoElement):
                    let overview = self.titles[indexPath.row].overview
                    let model = TitlePreviewModel(titleName: titleName, videoInfo: videoElement, overview: overview ?? "No description available.")
                    self.delegate?.didTapCollectionViewTableViewCell(self, model: model)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
}
