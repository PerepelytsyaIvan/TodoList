//
//  ConfirmTheDataController.swift
//  TodoList
//
//  Created by Dream Store on 07.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

class ConfirmTheDataController: UIViewController {
    //MARK:- @IBOutlets
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Veriable
    let setupModel = SetupModel()
    var model = Model()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DataConfirmationCell", bundle: nil), forCellReuseIdentifier: "DataConfirmationCell")
        tableView.tableFooterView = UIView()
        saveButton.layer.cornerRadius = 40
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - @IBAction
    @IBAction func saveButton(_ sender: UIButton) {
        setupModel.saveTask(task: model)
        setupModel.save()
        let vc = storyboard?.instantiateViewController(withIdentifier: "taskVC") as! TasksViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension ConfirmTheDataController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayElementTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataConfirmationCell", for: indexPath) as! DataConfirmationCell
        let indexPathString = String(1 + indexPath.row)
        cell.setupCell(detail: model, element: arrayElementTask[indexPath.row], number: indexPathString)
        return cell
    }
}
//MARK: - UITableViewDelegate
extension ConfirmTheDataController: UITableViewDelegate {
    
}
