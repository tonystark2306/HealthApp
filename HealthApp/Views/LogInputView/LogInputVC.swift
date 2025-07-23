//
//  LogInputVC.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/15/25.
//

import UIKit

class LogInputVC: UIViewController {
    
    
    @IBOutlet weak var pulseTF: CustomTF!
    
    @IBOutlet weak var hrvTF: CustomTF!
    override func viewDidLoad() {
        super.viewDidLoad()
        pulseTF.textField.placeholder = "Enter your pulse"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        pulseTF.textField.leftView = paddingView
        pulseTF.textField.leftViewMode = .always
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        hrvTF.textField.placeholder = "Enter your HRV"
        hrvTF.textField.leftView = paddingView1
        hrvTF.textField.leftViewMode = .always
    }
}

#Preview {
    LogInputVC()
}
