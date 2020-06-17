//
//  CreateTaskViewController.swift
//  TodoList
//
//  Created by Dream Store on 19.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class CreateTaskViewController: UIViewController {

    //MARK: - Veriable
    var saveAndCreate = true
    var dataSource: [Model] = []
    var index = Int()
    
    //MARK: @IBOutlet
    @IBOutlet private weak var createdTaskTableView: UITableView!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createTask))
        configureTableView()
    }
    
    //MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        createdTaskTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configureTableView() {
        createdTaskTableView.tableFooterView = UIView()
        
        createdTaskTableView.rowHeight = UITableView.automaticDimension
        createdTaskTableView.register(UINib(nibName: "CreateNameCell", bundle: nil), forCellReuseIdentifier: "name")
        createdTaskTableView.register(UINib(nibName: "CreateDiscriptionCell", bundle: nil), forCellReuseIdentifier: "discription")
        createdTaskTableView.register(UINib(nibName: "CreateTimeIntervalCell", bundle: nil), forCellReuseIdentifier: "time")
        createdTaskTableView.register(UINib(nibName: "CreateStatusTaskCell", bundle: nil), forCellReuseIdentifier: "status")
        createdTaskTableView.register(UINib(nibName: "CreateDateCell", bundle: nil), forCellReuseIdentifier: "date")
    }
    
    @objc private func createTask() {
        var task = Model()
        let name = createdTaskTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! CreateNameCell
        let discription = createdTaskTableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! CreateDiscriptionCell
        let time = createdTaskTableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! CreateTimeIntervalCell
        let status = createdTaskTableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! CreateStatusTaskCell
        let date = createdTaskTableView.cellForRow(at: IndexPath.init(row: 4, section: 0)) as! CreateDateCell
        task.name = name.name
        task.discription = discription.descriptionTask
        task.timeInterval = time.time
        task.status = status.status
        task.date = date.date
        task.statusTask = false
        
        if saveAndCreate == true {
            if task.name == nil {
                let alert = UIAlertController(title: nil, message: "You have not filled in all the fields", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "To fill", style: .cancel, handler: nil)
                let alertAction1 = UIAlertAction(title: "Return to tasks", style: .default) { (_) in
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "taskVC") as? TasksViewController else { return }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                alert.addAction(alertAction)
                alert.addAction(alertAction1)
                present(alert, animated: true, completion: nil)
                return
            }
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "taskVC") as? TasksViewController else { return }
            DataMeneger.shared.arrayTask.append(task)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            DataMeneger.shared.arrayTask.insert(task, at: index)
            if DataMeneger.shared.arrayTask.count > 1 {
                DataMeneger.shared.arrayTask.remove(at: index + 1)
            }
            let vc = storyboard?.instantiateViewController(withIdentifier: "taskVC") as! TasksViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - UITableViewDataSource
extension CreateTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayElementTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cellName = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath) as! CreateNameCell
            return cellName
        case 1:
            let cellDiscription = tableView.dequeueReusableCell(withIdentifier: "discription", for: indexPath) as! CreateDiscriptionCell
            return cellDiscription
        case 2:
            let cellTime = tableView.dequeueReusableCell(withIdentifier: "time", for: indexPath) as! CreateTimeIntervalCell
            return cellTime
        case 3:
            let cellStatus = tableView.dequeueReusableCell(withIdentifier: "status", for: indexPath) as! CreateStatusTaskCell
            return cellStatus
        case 4:
            let cellDate = tableView.dequeueReusableCell(withIdentifier: "date", for: indexPath) as! CreateDateCell
            return cellDate
        default:
            break
        }
        return UITableViewCell()
    }
}

//MARK: - UITableViewDelegate
extension CreateTaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            tableView.beginUpdates()
            let cell = tableView.cellForRow(at: indexPath) as! CreateNameCell
            cell.changeHeight()
            tableView.endUpdates()
        case 1:
            tableView.beginUpdates()
            let cell = tableView.cellForRow(at: indexPath) as! CreateDiscriptionCell
            cell.changeHeight()
            tableView.endUpdates()
        case 2:
            tableView.beginUpdates()
            let cell = tableView.cellForRow(at: indexPath) as! CreateTimeIntervalCell
            cell.changeHeight()
            tableView.endUpdates()
        case 3:
            tableView.beginUpdates()
            let cell = tableView.cellForRow(at: indexPath) as! CreateStatusTaskCell
            cell.changeHeight()
            tableView.endUpdates()
        case 4:
            tableView.beginUpdates()
            let cell = tableView.cellForRow(at: indexPath) as! CreateDateCell
            cell.changeHeight()
            tableView.endUpdates()
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
