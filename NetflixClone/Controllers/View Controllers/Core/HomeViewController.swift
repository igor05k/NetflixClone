import UIKit

enum Sections: Int {
    case popular = 0
    case trendingTv = 1
    case trendingMovies = 2
    case upcomingMovies = 3
    case topRated = 4
}

class HomeViewController: UIViewController {
    private let sections = ["Popular", "Trending Shows", "Trending movies", "Upcoming Movies", "Top rated"]
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insetsLayoutMarginsFromSafeArea = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = .leastNormalMagnitude
        view.addSubview(tableView)
        view.backgroundColor = .defaultBackgroundColor
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        
        tableView.tableHeaderView = headerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.text = header.textLabel?.text?.capitalized
        header.textLabel?.textColor = .white
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case Sections.popular.rawValue:
            APICaller.shared.getPopularTVShows { result in
                switch result {
                case .success(let success):
                    cell.feedTitlesArray(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            
        case Sections.trendingTv.rawValue:
            APICaller.shared.getTrendingTVShows { result in
                switch result {
                case .success(let success):
                    cell.feedTitlesArray(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            
        case Sections.trendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let success):
                    cell.feedTitlesArray(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            
        case Sections.upcomingMovies.rawValue:
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let success):
                    cell.feedTitlesArray(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            
        case Sections.topRated.rawValue:
            APICaller.shared.getTopRatedMovies { result in
                switch result {
                case .success(let success):
                    cell.feedTitlesArray(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
