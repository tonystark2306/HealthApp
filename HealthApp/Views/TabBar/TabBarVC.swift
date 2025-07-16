import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tabBar.tintColor = UIColor(named: "activeButton")
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true

        
        let vc1 = UINavigationController(rootViewController: ReportVC())
        let vc2 = UINavigationController(rootViewController: SettingVC())
        
        vc1.tabBarItem.image = UIImage(named: "reportTbIcon")
        vc2.tabBarItem.image = UIImage(named: "settingTbIcon")
        
        vc1.title = "Report"
        vc2.title = "Setting"
        
        setViewControllers([vc1, vc2], animated: true)
    }

}

#Preview {
    MainTabBarController()
}
