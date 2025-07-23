//
//  FourthOnboardingVC.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/23/25.
//

import UIKit

class FourthOnboardingVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var continueButton: UIButton!

    private let options: [(title: String, imageName: String)] = [
        ("Educational Plan", "educationalPlan"),
        ("Exercise Plan", "exercisePlan"),
        ("Health Tests", "healthTests"),
    ]
    
    private var selectedIndexes: Set<Int> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        continueButton.backgroundColor = UIColor(named: "inactiveButton")
        continueButton.layer.cornerRadius = 16
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SelectableOptionCell", bundle: nil), forCellWithReuseIdentifier: "OptionCell")
        
    }
    

    private func updateContinueButtonState() {
        let isAnySelected = !selectedIndexes.isEmpty
        if isAnySelected {
            continueButton.isEnabled = true
            continueButton.backgroundColor = UIColor(named: "activeButton")
        }
        else
        {
            continueButton.isEnabled = false
            continueButton.backgroundColor = UIColor(named: "inactiveButton")
        }
    }
    
    
    @IBAction func didTappedContinue(_ sender: Any) {
        let nextVC = MainTabBarController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension FourthOnboardingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCell", for: indexPath) as! SelectableOptionCell
        let option = options[indexPath.item]
        let isSelected = selectedIndexes.contains(indexPath.item)
        cell.configure(title: option.title, imageName: option.imageName, isSelected: isSelected)
        return cell
    }
}

extension FourthOnboardingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath.item) {
            selectedIndexes.remove(indexPath.item)
        } else {
            selectedIndexes.insert(indexPath.item)
        }
        
        collectionView.reloadItems(at: [indexPath])
        updateContinueButtonState()
    }
}

extension FourthOnboardingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let availableWidth = collectionView.frame.width - 2 * padding
        let itemWidth = availableWidth / 2
        let itemHeight: CGFloat = 195
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

#Preview {
    FourthOnboardingVC()
}
