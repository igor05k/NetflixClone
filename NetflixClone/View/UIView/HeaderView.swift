import UIKit

class HeaderView: UIView {
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addGradient()
        setNetflixLogo()
        setPlayButton()
        setTopStackView()
        setLeftStackView()
        setRightStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    // MARK: Image views
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "dune")
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var netflixLogoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "netflixLogo")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var addImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "plus")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var infoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "info.circle")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: Labels
    private lazy var listLabel: UILabel = {
        let label = UILabel()
        label.text = "My list"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Info"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var tvShowsLabel: UILabel = {
        let label = UILabel()
        label.text = "TV Shows"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var moviesLabel: UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var myListLabel: UILabel = {
        let label = UILabel()
        label.text = "My List"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: Buttons
    private lazy var playButton: UIButton = {
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
    
    // MARK: Stack views
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 25
        return stack
    }()
    
    private lazy var leftStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
    
    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.defaultBackgroundColor.cgColor
        ]
        
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    // MARK: Constraints
    private func setNetflixLogo() {
        addSubview(netflixLogoImageView)
        
        NSLayoutConstraint.activate([
            netflixLogoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            netflixLogoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            netflixLogoImageView.widthAnchor.constraint(equalToConstant: 60),
            netflixLogoImageView.heightAnchor.constraint(equalToConstant: 60),
        ])
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
    
    private func setLeftStackView() {
        self.addSubview(leftStackView)
        leftStackView.addArrangedSubview(addImageView)
        leftStackView.addArrangedSubview(listLabel)
        
        NSLayoutConstraint.activate([
            leftStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 45),
            leftStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            leftStackView.heightAnchor.constraint(equalToConstant: 50),
            leftStackView.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setRightStackView() {
        self.addSubview(rightStackView)
        rightStackView.addArrangedSubview(infoImageView)
        rightStackView.addArrangedSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            rightStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -45),
            rightStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            rightStackView.heightAnchor.constraint(equalToConstant: 50),
            rightStackView.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setTopStackView() {
        self.addSubview(topStackView)
        topStackView.addArrangedSubview(tvShowsLabel)
        topStackView.addArrangedSubview(moviesLabel)
        topStackView.addArrangedSubview(myListLabel)
        
        NSLayoutConstraint.activate([
            topStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topStackView.centerYAnchor.constraint(equalTo: netflixLogoImageView.centerYAnchor),
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
        ])
    }
    
    // MARK: Public funcs
    public func configure(with model: TitlesModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.image)") else { return }
        
        imageView.sd_setImage(with: url, completed: nil)
    }
}
