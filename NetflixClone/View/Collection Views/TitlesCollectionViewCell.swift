//
//  TitlesCollectionViewCell.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 25/09/22.
//

import UIKit
import SDWebImage

class TitlesCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: TitlesCollectionViewCell.self)
    
    lazy var posterImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return }
        posterImageView.sd_setImage(with: url)
    }
}
