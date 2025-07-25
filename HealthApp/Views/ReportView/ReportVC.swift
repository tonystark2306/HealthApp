//
//  ReportVC.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/15/25.
//

import UIKit

class ReportVC: UIViewController {
    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var logs: [HealthLog] = [] {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        tableView.reloadData()
        tableView.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupViews()
    }
    
    
    private func setupViews() {
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
            self?.logs.insert(newLog, at: 0)
        }
        let navController = UINavigationController(rootViewController: logVC)
        present(navController, animated: true)
    }
    
}

extension ReportVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return logs.isEmpty ? 2 : logs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if logs.isEmpty {
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
            cell.configure(with: logs[indexPath.section])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if logs.isEmpty {
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
}

#Preview {
    ReportVC()
}
