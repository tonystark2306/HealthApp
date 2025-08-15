//
//  ReportVC.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/15/25.
//

import UIKit
import RealmSwift

class ReportVC: UIViewController {
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var realm: Realm!
    private var logs: Results<HealthLog>?
    private var notificationToken: NotificationToken?
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        setupRealm()
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Health Guru"
        titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        titleLabel.textColor = UIColor.neutral1
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    private func setupRealm() {
        do {
            realm = try Realm()
            loadLogs()
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    private func loadLogs() {
        guard let realm = realm else { return }
        
        logs = realm.objects(HealthLog.self).sorted(byKeyPath: "createdAt", ascending: false)
        
        notificationToken = logs?.observe { [weak self] _ in
            self?.updateUI()
        }
    }
    
    private func setupUI() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        
        let logCellNib = UINib(nibName: "LogCell", bundle: nil)
        tableView.register(logCellNib, forCellReuseIdentifier: "LogCell")
        
        let trackDailyCellNib = UINib(nibName: "TrackDailyCell", bundle: nil)
        tableView.register(trackDailyCellNib, forCellReuseIdentifier: "TrackDailyCell")
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableHeaderView = UIView(frame: .zero)
    }
    
    @IBAction func heartButtonTapped(_ sender: Any) {
        let logVC = LogInputVC()
        logVC.onAddLog = { [weak self] newLog in
            guard let realm = self?.realm else { return }
            do {
                try realm.write {
                    realm.add(newLog)
                }
            } catch {
                print("Error save: \(error)")
            }
        }
        let navController = UINavigationController(rootViewController: logVC)
        present(navController, animated: true)
    }
}

extension ReportVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if logs?.isEmpty == false {
            return logs?.count ?? 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if logs?.isEmpty != false {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as! LogCell
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.configureEmpty()
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TrackDailyCell", for: indexPath) as! TrackDailyCell
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as! LogCell
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            if let logs = logs, indexPath.section < logs.count {
                cell.configure(with: logs[indexPath.section])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if logs?.isEmpty != false {
            if section == 0 {
                return 24
            } else {
                return 0
            }
        } else {
            return 12
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self, let logs = self.logs, indexPath.section < logs.count else {
                completionHandler(false)
                return
            }
            
            let logToDelete = logs[indexPath.section]
            
            do {
                try self.realm.write {
                    self.realm.delete(logToDelete)
                }
                completionHandler(true)
            } catch {
                print("Error delete: \(error)")
                completionHandler(false)
            }
        }
        
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
}
