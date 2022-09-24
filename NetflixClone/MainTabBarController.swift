import UIKit

class MainTabBarController: UITabBarController {
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    let comingSoonVC = UINavigationController(rootViewController: ComingSoon())
    let topSearchesVC = UINavigationController(rootViewController: TopSearches())
    let downloadsVC = UINavigationController(rootViewController: DownloadsViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarTitles()
        setTabBarImages()
        setTabBarViewControllers()
        tabBar.tintColor = .label
    }
    
    private func setTabBarTitles() {
        homeVC.title = "Home"
        comingSoonVC.title = "Coming Soon"
        topSearchesVC.title = "Top Searches"
        downloadsVC.title = "Downloads"
    }
    
    private func setTabBarViewControllers() {
        setViewControllers([homeVC, comingSoonVC, topSearchesVC, downloadsVC], animated: true)
    }
    
    private func setTabBarImages() {
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        comingSoonVC.tabBarItem.image = UIImage(systemName: "play.circle")
        topSearchesVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadsVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
    }
}

