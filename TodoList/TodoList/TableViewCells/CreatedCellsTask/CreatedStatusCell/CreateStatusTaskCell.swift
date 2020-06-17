//
//  CreateStatusTaskCell.swift
//  TodoList
//
//  Created by Dream Store on 19.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

class CreateStatusTaskCell: UITableViewCell {
    
    @IBOutlet weak var numberCellLabel: UILabel!
    @IBOutlet weak var statusSegment: UISegmentedControl!
    @IBOutlet weak var heightConstraintSegment: NSLayoutConstraint!
    
    var isOpened = false
    var status: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        statusSegment.isHidden = true
        numberCellLabel.clipsToBounds = true
        numberCellLabel.layer.cornerRadius = numberCellLabel.frame.width / 2
        statusSegment.addTarget(self, action: #selector(dataFilling), for: .valueChanged)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        heightConstraintSegment.constant = 0.0
        statusSegment.isHidden = isOpened
    }
    @objc func dataFilling() {
        if statusSegment.selectedSegmentIndex == 0 {
            status = "Urgently"
        } else {
            status = "Not necessary"
        }
    }
    func changeHeight() {
        heightConstraintSegment.constant = isOpened ? 0.0 : 27.0
        statusSegment.isHidden = isOpened
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layoutIfNeeded()
        }
        isOpened = !isOpened
    }
}
