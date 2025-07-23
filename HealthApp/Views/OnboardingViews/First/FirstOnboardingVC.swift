//
//  FirstOnboardingVC.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/12/25.
//

import UIKit

class FirstOnboardingVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didTappedContinue(_ sender: Any) {
        let nextVC = SecondOnboardingVC(nibName: "SecondOnboardingVC", bundle: nil)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    

}
#Preview {
    FirstOnboardingVC()
}
