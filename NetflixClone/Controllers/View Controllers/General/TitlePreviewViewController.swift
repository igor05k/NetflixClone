//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 18/10/22.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    lazy var webView: WKWebView = {
        let webV = WKWebView()
        webV.translatesAutoresizingMaskIntoConstraints = false
        webV.contentMode = .scaleAspectFill
        return webV
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 22, weight: .bold)
        title.text = "Movie title"
        title.tintColor = .white
        return title
    }()
    
    lazy var overviewLabel: UILabel = {
        let overview = UILabel()
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.numberOfLines = 0
        overview.text = "This is a sample text for a overview movie title."
        overview.tintColor = .white
        overview.font = .systemFont(ofSize: 18, weight: .regular)
        return overview
    }()
    
    lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemRed
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScrollViewConstraints()
        setContentViewConstraints()
        setWebViewConstraints()
        setTitleLabelConstraints()
        setOverviewLabelConstraints()
        setDownloadButtonConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setScrollViewConstraints() {
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func setContentViewConstraints() {
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func setWebViewConstraints() {
        contentView.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: contentView.topAnchor),
            webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    private func setTitleLabelConstraints() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setOverviewLabelConstraints() {
        contentView.addSubview(overviewLabel)
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
    }
    
    private func setDownloadButtonConstraints() {
        contentView.addSubview(downloadButton)
        
        NSLayoutConstraint.activate([
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            downloadButton.widthAnchor.constraint(equalToConstant: 110),
            downloadButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    public func configure(with model: TitlePreviewModel) {
        titleLabel.text = model.titleName
        overviewLabel.text = model.overview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.videoInfo.id.videoId)") else { return }
        self.webView.load(URLRequest(url: url))
    }
}
