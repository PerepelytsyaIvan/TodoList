//
//  CreateNameCell.swift
//  TodoList
//
//  Created by Dream Store on 19.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

class CreateNameCell: UITableViewCell {

    //MARK: Veriable
    var name: String?
    var isOpened = false
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var numberCellLabel: UILabel!
    @IBOutlet private weak var taskNameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var heightConstraintTextField: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameTextField.delegate = self
        nameTextField.returnKeyType = UIReturnKeyType.done
        numberCellLabel.clipsToBounds = true
        numberCellLabel.layer.cornerRadius = numberCellLabel.frame.width / 2
    }
    override func prepareForReuse() {
        heightConstraintTextField.constant = 0.0
    }

    //MARK: - Methods
    func changeHeight() {
        heightConstraintTextField.constant = isOpened ? 0.0 : 31.0
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layoutIfNeeded()
        }
        isOpened = !isOpened
    }
}

//MARK: - UITextFieldDelegate
extension CreateNameCell: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        name = nameTextField.text
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
