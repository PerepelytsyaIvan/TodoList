//
//  MyTaskCell.swift
//  TodoList
//
//  Created by Dream Store on 08.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
protocol TaskTableViewDelegate {
    func didTappedOnButton(from cell: MyTaskCell)
}

class MyTaskCell: UITableViewCell {
    //MARK: - @IBOutlet
    @IBOutlet weak var nameTaskLabel: UILabel!
    @IBOutlet weak var discriptionTaskLabel: UILabel!
    @IBOutlet weak var statusTaskLabel: UILabel!
    @IBOutlet weak var timeTaskLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    var delegate: TaskTableViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    
    //MARK: - Methods
    func setupCell(task: Model) {
        if task.status == arrayStatus[0] {
            statusTaskLabel.textColor = .red
        } else {
            statusTaskLabel.textColor = .yellow
        }
        nameTaskLabel.text = task.name
        discriptionTaskLabel.text = task.discription
        statusTaskLabel.text = task.status
        timeTaskLabel.text = task.timeInterval
        createdDateLabel.text = task.date
    }
    @IBAction func detailButton(_ sender: Any) {
        delegate?.didTappedOnButton(from: self)
    }
}
