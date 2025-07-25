import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarAppearance()
        setupViewControllers()
    }

    private func setupTabBarAppearance() {
        
        tabBar.tintColor = UIColor(named: "activeButton")
        tabBar.unselectedItemTintColor = .neutral4
        tabBar.backgroundColor = .white

        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.masksToBounds = false
        tabBar.layer.cornerRadius = 20

        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]

        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .selected)
    }

    private func setupViewControllers() {
        let vc1 = UINavigationController(rootViewController: ReportVC())
        let vc2 = UINavigationController(rootViewController: SettingVC())

        vc1.tabBarItem = UITabBarItem(title: "Report", image: UIImage(named: "reportTbIcon"), tag: 0)
        vc2.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settingTbIcon"), tag: 1)

        setViewControllers([vc1, vc2], animated: true)
    }
}

#Preview {
    MainTabBarController()
}
