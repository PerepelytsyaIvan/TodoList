//
//  CreateTimeIntervalCell.swift
//  TodoList
//
//  Created by Dream Store on 19.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

class CreateTimeIntervalCell: UITableViewCell {
var isOpened = false
    @IBOutlet weak var timeTaskDatePicker: UIDatePicker!
    @IBOutlet weak var heightConstraintPicker: NSLayoutConstraint!
    @IBOutlet weak var numberCellLabel: UILabel!
    var time: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        numberCellLabel.clipsToBounds = true
        numberCellLabel.layer.cornerRadius = numberCellLabel.frame.width / 2
        timeTaskDatePicker.datePickerMode = .time
        timeTaskDatePicker.addTarget(self, action: #selector(createTime), for: .valueChanged)
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
    @objc private func createTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm"
        time = dateFormatter.string(from: timeTaskDatePicker.date)
    }
}
