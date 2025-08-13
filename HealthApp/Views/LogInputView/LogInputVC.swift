//
//  LogInputVC.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/15/25.
//

import UIKit

class LogInputVC: UIViewController {
    
    var onAddLog: ((HealthLog) -> Void)?
    
    @IBOutlet weak var pulseTF: CustomTF!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var hrvTF: CustomTF!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupTargets()
    }
    
    private func setupUI() {
        title = "Information"
        pulseTF.textField.placeholder = "Enter your pulse"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        pulseTF.textField.leftView = paddingView
        pulseTF.textField.leftViewMode = .always
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        hrvTF.textField.placeholder = "Enter your HRV"
        hrvTF.textField.leftView = paddingView1
        hrvTF.textField.leftViewMode = .always
        addButton.backgroundColor = UIColor(named: "inactiveButton")
        addButton.layer.cornerRadius = 16
        addButton.tintColor = .white
        addButton.isEnabled = false
        addButton.setTitleColor(.white, for: .disabled)
    }
    
    private func setupNavigationBar() {
        let image = UIImage(named: "closeButton")?.withRenderingMode(.alwaysOriginal)
        let closeButton = UIBarButtonItem(image: image,
                                          style: .plain,
                                          target: self,
                                          action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem = closeButton
    }

    
    private func setupTargets() {
        pulseTF.textField.addTarget(self, action: #selector(fieldsChanged), for: .editingChanged)
        hrvTF.textField.addTarget(self, action: #selector(fieldsChanged), for: .editingChanged)
    }

    @objc private func fieldsChanged() {
        let pulseValid = !(pulseTF.textField.text?.isEmpty ?? true)
        let hrvValid = !(hrvTF.textField.text?.isEmpty ?? true)

        if pulseValid && hrvValid {
            addButton.isEnabled = true
            addButton.backgroundColor = UIColor(named: "activeButton")
        } else {
            addButton.isEnabled = false
            addButton.backgroundColor = UIColor(named: "inactiveButton")
        }
    }
    
    @IBAction func didTappedAdd(_ sender: Any) {
        guard
            let pulseText = pulseTF.textField.text, let pulse = Int(pulseText),
            let hrvText = hrvTF.textField.text, let hrv = Int(hrvText)
        else { return }

        let newLog = HealthLog(pulse: pulse, hrv: hrv)
        onAddLog?(newLog)
        dismiss(animated: true)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true)
    }
}

