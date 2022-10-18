import UIKit

class UpcomingViewController: UIViewController {
    var titles: [MoviesAndTVShows] = [MoviesAndTVShows]()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(TitlesTableViewCell.self, forCellReuseIdentifier: TitlesTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcoming"
        self.view.backgroundColor = .defaultBackgroundColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let array):
                self.titles = array
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitlesTableViewCell.identifier, for: indexPath) as? TitlesTableViewCell else { return UITableViewCell() }
        
        if let movieTitle = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title,
            let posterImage = titles[indexPath.row].poster_path {
            cell.configure(with: TitlesModel(title: movieTitle, image: posterImage))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let titleName = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title else { return }
        guard let movieOverview = titles[indexPath.row].overview else { return }
        
        APICaller.shared.youtubeSearch(with: titleName + " trailer") { result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let previewViewController = TitlePreviewViewController()
                    previewViewController.configure(with: TitlePreviewModel(titleName: titleName, videoInfo: videoElement, overview: movieOverview))
                    self.navigationController?.pushViewController(previewViewController, animated: true)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
