//
//  ProfileVC.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/15/25.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bmiValueLabel: UILabel!
    @IBOutlet weak var weightValue: UILabel!
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var genderValue: UILabel!
    var onDataUpdated: ((UserData) -> Void)?
    var onProfileDeleted: (() -> Void)?
    
    private var currentUserData: UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            tabBarController?.tabBar.isHidden = false
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        navigationController?.navigationBar.tintColor = .black
   
        navigationItem.hidesBackButton = true

        let backImage = UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(
            image: backImage,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem = backButton

        let editButton = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        editButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.primary2
        ], for: .normal)
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        title = "Profile"
        containerView.clipsToBounds = true
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupWithUserData(_ userData: UserData) {
        currentUserData = userData
        if isViewLoaded {
            updateUI()
        }
    }
    
    private func updateUI() {
        guard isViewLoaded,
              userNameLabel != nil,
              bmiValueLabel != nil,
              weightValue != nil,
              heightValue != nil,
              genderValue != nil else {
            return
        }
        
        guard let userData = currentUserData else {
            userNameLabel.text = "----"
            bmiValueLabel.text = "---"
            weightValue.text = "---"
            heightValue.text = "---"
            genderValue.text = "---"
            return
        }
        
        userNameLabel.text = "\(userData.firstName) \(userData.lastName)"
        weightValue.text = "\(userData.weight) kg"
        heightValue.text = "\(userData.height) cm"
        genderValue.text = userData.gender
        
        if let weight = Double(userData.weight), let height = Double(userData.height), height > 0 {
            let heightInMeters = height / 100
            let bmi = weight / (heightInMeters * heightInMeters)
            bmiValueLabel.text = String(format: "%.1f", bmi)
        } else {
            bmiValueLabel.text = "---"
        }
    }
    
    @objc private func editButtonTapped() {
        let informationVC = InfoVC()
        informationVC.userData = currentUserData
        informationVC.onDataUpdated = { [weak self] updatedData in
            self?.updateUserData(updatedData)
        }
        navigationController?.pushViewController(informationVC, animated: true)
    }
    
    private func updateUserData(_ userData: UserData) {
        currentUserData = userData
        updateUI()
        onDataUpdated?(userData)
    }
}
