import UIKit

class SettingVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    struct SettingsItem {
        let title: String
        let icon: String
        let iconColor: UIColor = UIColor(named: "primary1")!
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
        title = "Settings"
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "bgColor")
        navigationController?.setNavigationBarHidden(true, animated: false)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingCell;
        
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
        print("Navigate to Profile")
    }
}

#Preview {
    SettingVC()
}
