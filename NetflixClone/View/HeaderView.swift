import UIKit

class HeaderView: UIView {
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "dune")
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var playButton: UIButton = {
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("Play", attributes: container)
        configuration.image = UIImage(systemName: "play.fill")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        
        let bttn = UIButton(configuration: configuration)
        bttn.translatesAutoresizingMaskIntoConstraints = false
        bttn.setTitleColor(.black, for: .normal)
        bttn.layer.borderColor = UIColor.white.cgColor
        bttn.layer.borderWidth = 1
        bttn.layer.cornerRadius = 5
        bttn.backgroundColor = .white
        bttn.tintColor = .black
        
        return bttn
    }()
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.defaultBackgroundColor.cgColor
        ]
        
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addGradient()
        setPlayButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    private func setPlayButton() {
        addSubview(playButton)
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
}
