//
//  CreateDateCell.swift
//  TodoList
//
//  Created by Dream Store on 19.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

class CreateDateCell: UITableViewCell {
    
    var isOpened = false
    var date: String?
    
    @IBOutlet weak var createdDatePicker: UIDatePicker!
    @IBOutlet weak var numberCellLabel: UILabel!
    @IBOutlet weak var heightConstraintPicker: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberCellLabel.clipsToBounds = true
        numberCellLabel.layer.cornerRadius = numberCellLabel.frame.width / 2
         createdDatePicker.datePickerMode = .date
        createdDatePicker.addTarget(self, action: #selector(createDate), for: .valueChanged)
    }
    override func prepareForReuse() {
        heightConstraintPicker.constant = 0.0
    }
    func changeHeight() {
        heightConstraintPicker.constant = isOpened ? 0.0 : 140.0
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layoutIfNeeded()
        }
        isOpened = !isOpened
    }
    @objc private func createDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        date = dateFormatter.string(from: createdDatePicker.date)
    }
}
