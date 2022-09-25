import UIKit

class HomeViewController: UIViewController {
    private let sections = ["Popular", "Trending TV", "Trending movies", "Upcoming Movies", "Top rated"]
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .defaultBackgroundColor
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        
        tableView.tableHeaderView = headerView
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func fetchData() {
//        APICaller.shared.getTrendingMovies { results in
//            switch results {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        
//        APICaller.shared.getTrendingTVShows { results in
//            switch results {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        
//        APICaller.shared.getUpcomingMovies { _ in
//
//        }
        
//        APICaller.shared.getTopRatedMovies { _ in
//            //
//        }
        
//        APICaller.shared.getPopularTVShows { _ in
//            //
//        }
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
        cell.backgroundColor = .red
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
