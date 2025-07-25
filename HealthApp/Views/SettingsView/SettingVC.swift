import UIKit

class SettingVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    struct SettingsItem {
        let title: String
        let icon: String
        let iconColor: UIColor = UIColor(named: "primary1") ?? UIColor.systemBlue
    }
    
    let settingsData: [[SettingsItem]] = [
        [
            SettingsItem(title: "Profile", icon: "profile")
        ],
        [
            SettingsItem(title: "Daily Reminder", icon: "dailyReminder"),
            SettingsItem(title: "Change App Icon", icon: "changeAppIcon"),
            SettingsItem(title: "Language", icon: "language")
        ],
        [
            SettingsItem(title: "Rate Us", icon: "rateUs"),
            SettingsItem(title: "Feedback", icon: "feedback"),
            SettingsItem(title: "Privacy Policy", icon: "privacyPolicy"),
            SettingsItem(title: "Term of User", icon: "termOfUser")
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        titleLabel.textColor = UIColor.neutral1
        titleLabel.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "SettingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SettingsCell")
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}

extension SettingVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingCell
        
        let item = settingsData[indexPath.section][indexPath.row]
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == settingsData[indexPath.section].count - 1
        let isOnlyCell = settingsData[indexPath.section].count == 1
        
        cell.configure(with: item, isFirstCell: isFirstCell, isLastCell: isLastCell, isOnlyCell: isOnlyCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 16
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}

extension SettingVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = settingsData[indexPath.section][indexPath.row]
        handleSettingsItemTap(item.title)
    }
    
    private func handleSettingsItemTap(_ title: String) {
        switch title {
        case "Profile":
            navigateToProfile()
        default:
            break
        }
    }
    
    private func navigateToProfile() {
        if UserDataManager.shared.hasUserData() {
            navigateToProfileScreen()
        } else {
            navigateToInfoScreen()
        }
    }
    
    private func navigateToProfileScreen() {
        let profileVC = ProfileVC()
        
        if let userData = UserDataManager.shared.currentUserData {
            profileVC.setupWithUserData(userData)
        }
        
        profileVC.onDataUpdated = { [weak self] updatedData in
            UserDataManager.shared.saveUserData(updatedData)
        }
        
        profileVC.onProfileDeleted = { [weak self] in
            UserDataManager.shared.deleteUserData()
        }
        
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func navigateToInfoScreen() {
        let informationVC = InfoVC()
        
        informationVC.onDataUpdated = { [weak self] newData in
            UserDataManager.shared.saveUserData(newData)
            DispatchQueue.main.async {
                self?.navigateToProfileFromInfo(with: newData)
            }
        }
        
        navigationController?.pushViewController(informationVC, animated: true)
    }
    
    private func navigateToProfileFromInfo(with userData: UserData) {
        let profileVC = ProfileVC()
        
        profileVC.setupWithUserData(userData)
        profileVC.onDataUpdated = { updatedData in
            UserDataManager.shared.saveUserData(updatedData)
        }
        
        profileVC.onProfileDeleted = {
            UserDataManager.shared.deleteUserData()
        }
        var viewControllers = navigationController?.viewControllers ?? []
        if viewControllers.count > 1 {
            viewControllers[viewControllers.count - 1] = profileVC
            navigationController?.setViewControllers(viewControllers, animated: true)
        }
    }
}
