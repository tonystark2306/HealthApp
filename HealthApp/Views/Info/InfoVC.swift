//
//  InfoVC.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/14/25.
//

import UIKit
import Combine

class InfoVC: UIViewController {
    
    @IBOutlet weak var firstNameTF: CustomTF!
    @IBOutlet weak var lastNameTF: CustomTF!
    @IBOutlet weak var weightTF: CustomTF!
    @IBOutlet weak var heightTF: CustomTF!
    @IBOutlet weak var genderSC: UISegmentedControl!
    @IBOutlet weak var updateButton: UIButton!
    
    private var cancellables = Set<AnyCancellable>()
    private let userDataManager = UserDataManager.shared
    
    var userData: UserData?
    private var selectedGender: String = "Male"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Information"
        setupUI()
        setupNavigationBar()
        setupActions()
        loadData()
    }
    
    private func setupUI() {
        firstNameTF.setPlaceholder("Enter first name...")
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        firstNameTF.textField.leftView = paddingView
        firstNameTF.textField.leftViewMode = .always
        
        lastNameTF.setPlaceholder("Enter last name...")
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        lastNameTF.textField.leftView = paddingView1
        lastNameTF.textField.leftViewMode = .always
        
        weightTF.setPlaceholder("Enter weight...")
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        weightTF.textField.leftView = paddingView2
        weightTF.textField.leftViewMode = .always
        
        heightTF.setPlaceholder("Enter height...")
        let paddingView3 = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        heightTF.textField.leftView = paddingView3
        heightTF.textField.leftViewMode = .always
        
        updateButton.backgroundColor = UIColor(named: "inactiveButton")
        updateButton.layer.cornerRadius = 16
        updateButton.isEnabled = false
        updateButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
    }
    
    private func setupActions() {
        genderSC.addTarget(self, action: #selector(genderSegmentChanged), for: .valueChanged)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        firstNameTF.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        lastNameTF.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        weightTF.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        heightTF.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func loadData() {
        if let data = userData {
            firstNameTF.textField.text = data.firstName
            lastNameTF.textField.text = data.lastName
            weightTF.textField.text = data.weight
            heightTF.textField.text = data.height
            
            if data.gender == "Female" {
                genderSC.selectedSegmentIndex = 1
                selectedGender = "Female"
            } else {
                genderSC.selectedSegmentIndex = 0
                selectedGender = "Male"
            }
        } else {
            firstNameTF.textField.text = ""
            lastNameTF.textField.text = ""
            weightTF.textField.text = ""
            heightTF.textField.text = ""
            
            genderSC.selectedSegmentIndex = 0
            selectedGender = "Male"
        }
        
        textFieldDidChange()
    }
    
    @objc private func genderSegmentChanged() {
        selectedGender = genderSC.selectedSegmentIndex == 0 ? "Male" : "Female"
        textFieldDidChange()
    }
    
    @objc private func textFieldDidChange() {
        let isValid = !(firstNameTF.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) &&
        !(lastNameTF.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) &&
        !(weightTF.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) &&
        !(heightTF.textField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) &&
                     !selectedGender.isEmpty
        
        updateButton.isEnabled = isValid
        if isValid {
            updateButton.backgroundColor = UIColor(named: "activeButton")
        } else {
            updateButton.backgroundColor = UIColor(named: "inactiveButton")
        }
    }
    
    @objc private func updateButtonTapped() {
        let resultData: UserData
        
        if let existingData = userData {
            resultData = UserData(
                id: existingData.id,
                firstName: firstNameTF.textField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                lastName: lastNameTF.textField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                weight: weightTF.textField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                height: heightTF.textField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                gender: selectedGender
            )
            userDataManager.updateProfile(resultData)
        } else {
            resultData = UserData(
                firstName: firstNameTF.textField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                lastName: lastNameTF.textField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                weight: weightTF.textField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                height: heightTF.textField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                gender: selectedGender
            )
            userDataManager.addProfile(resultData)
        }
        
        navigationController?.popViewController(animated: true)
    }
}

#Preview {
    InfoVC()
}
