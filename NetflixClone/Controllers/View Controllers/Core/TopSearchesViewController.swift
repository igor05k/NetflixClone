import UIKit

class TopSearchesViewController: UIViewController {
    private var titles: [MoviesAndTVShows] = [MoviesAndTVShows]()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(TitlesTableViewCell.self, forCellReuseIdentifier: TitlesTableViewCell.identifier)
        return table
    }()

    lazy var searchBarController: UISearchController = {
        let searchBarItem = UISearchController(searchResultsController: TopSearchesResultsController())
        searchBarItem.searchBar.placeholder = "Search for movie, tv show or person..."
        searchBarItem.searchBar.searchBarStyle = .minimal
        return searchBarItem
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        self.view.backgroundColor = .defaultBackgroundColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        navigationItem.searchController = searchBarController
        fetchDiscoveryMovies()
        
        searchBarController.searchResultsUpdater = self
    }
    
    func fetchDiscoveryMovies() {
        APICaller.shared.getDiscoveryMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.titles = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension TopSearchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitlesTableViewCell.identifier, for: indexPath) as? TitlesTableViewCell else { return UITableViewCell() }
        if let titleMovie = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title,
           let imagePoster = titles[indexPath.row].poster_path {
            cell.configure(with: TitlesModel(title: titleMovie, image: imagePoster))
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

extension TopSearchesViewController: UISearchResultsUpdating, TopSearchesResultsControllerDelegate {
    func didTapTopSearchesResultsController(model: TitlePreviewModel) {
        DispatchQueue.main.async {
            let previewViewController = TitlePreviewViewController()
            previewViewController.configure(with: model)
            self.navigationController?.pushViewController(previewViewController, animated: true)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBarText = searchBarController.searchBar
        
        guard let searchText = searchBarText.text,
              !searchText.trimmingCharacters(in: .whitespaces).isEmpty,
              searchText.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchBarController.searchResultsController as? TopSearchesResultsController else { return }
        resultController.delegate = self
        
        APICaller.shared.search(with: searchText) { result in
            switch result {
            case .success(let items):
                resultController.titles = items
                DispatchQueue.main.async {
                    resultController.collectionView.reloadData()
                }
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
}
