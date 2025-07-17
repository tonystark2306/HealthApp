//
//  ProfileVC.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/15/25.
//

import UIKit
import Combine

class ProfileVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bmiValueLabel: UILabel!
    @IBOutlet weak var weightValue: UILabel!
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var genderValue: UILabel!
    @IBOutlet weak var editButton: UIButton!
    private var cancellables = Set<AnyCancellable>()
    private let dataManager = UserDataManager.shared
    private var currentUserData: UserData?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        setupUI()
        setupNavigationBar()
        setupCombineBindings()
        setupEditButton()
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
        
        let deleteButton = UIBarButtonItem(
            image: UIImage(named: "deleteButton"),
            style: .plain,
            target: self,
            action: #selector(deleteButtonTapped)
        )
        deleteButton.tintColor = .red
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    private func setupEditButton() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    private func setupCombineBindings() {
        dataManager.$profiles
            .receive(on: DispatchQueue.main)
            .sink { [weak self] profiles in
                guard let self = self,
                      let currentData = self.currentUserData else { return }
                
                if let updatedData = profiles.first(where: { $0.id == currentData.id }) {
                    self.currentUserData = updatedData
                    self.updateProfileDisplay()
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func editButtonTapped() {
        let infoVC = InfoVC()
        infoVC.userData = currentUserData
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        guard let userData = currentUserData else { return }
        
        let alert = UIAlertController(
            title: "Delete Profile",
            message: "Are you sure you want to delete this profile?",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.dataManager.deleteProfile(userData.id)
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func setUserData(_ userData: UserData) {
        currentUserData = userData
        if isViewLoaded {
            updateProfileDisplay()
        }
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
