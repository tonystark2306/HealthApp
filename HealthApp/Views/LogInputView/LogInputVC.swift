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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

#Preview {
    LogInputVC()
}
