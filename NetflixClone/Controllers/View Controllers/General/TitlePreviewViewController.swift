//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 18/10/22.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let webV = WKWebView()
        webV.translatesAutoresizingMaskIntoConstraints = false
        webV.backgroundColor = .systemPink
        return webV
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 22, weight: .bold)
        title.text = "Movie title"
        title.tintColor = .black
        return title
    }()
    
    lazy var overviewLabel: UILabel = {
        let overview = UILabel()
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.numberOfLines = 0
        overview.text = "This is a sample text for a overview movie title."
        overview.tintColor = .black
        overview.font = .systemFont(ofSize: 18, weight: .regular)
        return overview
    }()
    
    lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPurple
        
        setWebViewConstraints()
        setTitleLabelConstraints()
        setOverviewLabelConstraints()
        setDownloadButtonConstraints()
    }
    
    private func setWebViewConstraints() {
        self.view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setTitleLabelConstraints() {
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setOverviewLabelConstraints() {
        self.view.addSubview(overviewLabel)
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
    }
    
    private func setDownloadButtonConstraints() {
        self.view.addSubview(downloadButton)
        
        NSLayoutConstraint.activate([
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
