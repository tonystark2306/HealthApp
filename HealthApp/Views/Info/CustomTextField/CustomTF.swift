//
//  CustomTF.swift
//  HealthApp
//
//  Created by iKame Elite Fresher 2025 on 7/15/25.
//

import UIKit

class CustomTF: UIView {

    @IBOutlet weak var textField: UITextField!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            loadFromNib()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            loadFromNib()
        }
        
        override func layoutSubviews() {
            
        }
        
    private func loadFromNib() {
        let nib = UINib(nibName: "CustomTF", bundle: nil)
        let nibView = nib.instantiate(withOwner: self).first as! UIView
        
        addSubview(nibView)
        
        nibView.translatesAutoresizingMaskIntoConstraints = false
        nibView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nibView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nibView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nibView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nibView.layer.cornerRadius = 16
        nibView.layer.borderWidth = 1
        nibView.layer.masksToBounds = true
        nibView.layer.borderColor = UIColor.neutral4.cgColor
    }
    
    func setPlaceholder(_ text: String) {
        let attributes: [NSAttributedString.Key: Any] = [
          .foregroundColor: UIColor.neutral3,
          .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }

}
