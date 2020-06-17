//
//  CreateDiscriptionCell.swift
//  TodoList
//
//  Created by Dream Store on 19.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

class CreateDiscriptionCell: UITableViewCell {

    @IBOutlet private weak var numberCellLabel: UILabel!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var heightConstraintTextField: NSLayoutConstraint!
    
    var isOpened = false
    var descriptionTask: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionTextField.delegate = self
        descriptionTextField.returnKeyType = UIReturnKeyType.done
        numberCellLabel.clipsToBounds = true
        numberCellLabel.layer.cornerRadius = numberCellLabel.frame.width / 2
    }
    override func prepareForReuse() {
        heightConstraintTextField.constant = 0.0
    }
    func changeHeight() {
        heightConstraintTextField.constant = isOpened ? 0.0 : 31.0
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layoutIfNeeded()
        }
        isOpened = !isOpened
    }
    
}
extension CreateDiscriptionCell: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        descriptionTask = descriptionTextField.text
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
