//
//  ProfileVC.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/15/25.
//

import UIKit

class ProfileVC: UIViewController {
    
    var onDataUpdated: ((UserData) -> Void)?
    
    var onProfileDeleted: (() -> Void)?
    
    private var currentUserData: UserData?

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var bmiValueLabel: UILabel!
    
    @IBOutlet weak var weightValue: UILabel!
    
    @IBOutlet weak var heightValue: UILabel!
    
    @IBOutlet weak var genderValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        setupUI()
        setupNavigationBar()
        updateProfileDisplay()
    }
    
    private func setupUI() {
        containerView.clipsToBounds = true
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false
    
        if currentUserData == nil {
            userNameLabel.text = "----"
            bmiValueLabel.text = "---"
            weightValue.text = "-- kg"
            heightValue.text = "-- cm"
            genderValue.text = "--"
        }
    }
    
    private func setupNavigationBar() {
            navigationController?.setNavigationBarHidden(false, animated: true)
            
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
            ]
            
            navigationController?.navigationBar.tintColor = .black
            navigationItem.backButtonTitle = ""
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
            navigationItem.rightBarButtonItem = editButton
        }
    

    
    @objc private func editButtonTapped() {
        let infoVC = InfoVC()
        infoVC.userData = currentUserData
        infoVC.onDataUpdated = { [weak self] updatedData in
            self?.currentUserData = updatedData
            self?.updateProfileDisplay()
            self?.onDataUpdated?(updatedData)
            self?.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
    func setUserData(_ userData: UserData) {
            currentUserData = userData
            if isViewLoaded {
                updateProfileDisplay()
            }
        }
    
    func setupWithUserData(_ userData: UserData) {
        currentUserData = userData
        updateProfileDisplay()
    }
        
        private func updateProfileDisplay() {
            guard let userData = currentUserData else { return }
            userNameLabel.text = "\(userData.firstName) \(userData.lastName)"
            weightValue.text = "\(userData.weight) kg"
            heightValue.text = "\(userData.height) cm"
            genderValue.text = userData.gender
            let bmi = calculateBMI(weight: userData.weight, height: userData.height)
            bmiValueLabel.text = String(format: "%.1f", bmi)
        }
    
        private func calculateBMI(weight: String, height: String) -> Double {
            guard let weightDouble = Double(weight),
                  let heightDouble = Double(height),
                  heightDouble > 0 else {
                return 0.0
            }
            let heightInMeters = heightDouble / 100.0
            let bmi = weightDouble / (heightInMeters * heightInMeters)
            return bmi
        }
        
}

#Preview {
    ProfileVC()
}
