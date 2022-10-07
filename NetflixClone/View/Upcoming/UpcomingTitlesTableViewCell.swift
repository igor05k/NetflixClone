//
//  UpcomingTitlesTableViewCell.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 07/10/22.
//

import UIKit

class UpcomingTitlesTableViewCell: UITableViewCell {
    static let identifier = String(describing: UpcomingTitlesTableViewCell.self)
    
    lazy var imageViewPoster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setVisualElements()
        setImageConstraints()
        setPlayButtonConstraints()
        setLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setVisualElements() {
        contentView.addSubview(imageViewPoster)
        contentView.addSubview(playButton)
        contentView.addSubview(titleLabel)
    }
    
    private func setImageConstraints() {
        NSLayoutConstraint.activate([
            imageViewPoster.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViewPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewPoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageViewPoster.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setPlayButtonConstraints() {
        NSLayoutConstraint.activate([
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
    }
    
    private func setLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageViewPoster.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -8)
        ])
    }
    
    public func configure(with viewModel: UpcomingTitlesViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.image)") else { return }
        imageViewPoster.sd_setImage(with: url, completed: nil)
        titleLabel.text = viewModel.title
    }
}
