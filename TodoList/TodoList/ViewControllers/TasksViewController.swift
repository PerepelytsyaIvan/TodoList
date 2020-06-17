//
//  TasksViewController.swift
//  TodoList
//
//  Created by Dream Store on 07.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//
import UIKit

final class TasksViewController: UIViewController {
    
    //MARK: Veriable
   private var dataSource: [Model] = []
   private var doneTask: [Model] = []
   private var notDoneTask: [Model] = []
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var taskTableView: UITableView!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = DataMeneger.shared.arrayTask
        configureTableView()
        configureNavigationItem()
        filterTask()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = DataMeneger.shared.arrayTask
    }
    
    //MARK: - Methods
    private func filterTask() {
        doneTask.removeAll()
        notDoneTask.removeAll()
        for model in dataSource {
            model.statusTask! ? doneTask.append(model) : notDoneTask.append(model)
        }
    }
    private func configureTableView() {
        taskTableView.register(UINib(nibName: "MyTaskCell", bundle: nil), forCellReuseIdentifier: "MyTaskCell")
    }
    
    private func configureNavigationItem() {
        title = "My to-do list"
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(transitionVC))
    }
    
    @objc func transitionVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "create") as! CreateTaskViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 where !notDoneTask.isEmpty:
            return notDoneTask.count
        case 1 where !doneTask.isEmpty:
            return doneTask.count
        default:
            break
        }
        if dataSource.isEmpty {
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            emptyLabel.text = "No task"
            emptyLabel.textAlignment = NSTextAlignment.center
            tableView.backgroundView = emptyLabel
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTaskCell", for: indexPath) as! MyTaskCell
        if indexPath.section == 0 {
            cell.delegate = self
            cell.setupCell(task: notDoneTask[indexPath.row])
        } else {
            cell.changeButton.isHidden = true
            cell.setupCell(task: doneTask[indexPath.row])
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 where !notDoneTask.isEmpty :
            return "Not done"
        case 1 where !doneTask.isEmpty:
            return "Done"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let arrayTask = section == 0 ? notDoneTask : doneTask
        return arrayTask.isEmpty ? 0.01 : 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 150, y: 8, width: 180, height: 50)
        myLabel.font = UIFont.boldSystemFont(ofSize: 25)
        if section == 0 {
            myLabel.textColor = #colorLiteral(red: 0.7790028453, green: 0.6009230018, blue: 0.08006858081, alpha: 1)
        } else {
            myLabel.textColor = #colorLiteral(red: 0.1489653885, green: 0.6775699258, blue: 0.0850309059, alpha: 1)
        }
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView
    }
}

//MARK: - UITableViewDelegate
extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipe = UIContextualAction(style: .normal, title: nil) {[weak self] (action, view, success) in
            DataMeneger.shared.arrayTask.remove(at: indexPath.row)
            self?.dataSource.remove(at: indexPath.row)
            self?.filterTask()
            self?.taskTableView.reloadData()
            success(true)
        }
        swipe.image = #imageLiteral(resourceName: "icons8-add-to-shopping-basket-64")
        swipe.backgroundColor = .red
        
        let swipeComplited = UIContextualAction(style: .normal, title: "Done") {[weak self] (action, view, success) in
            DataMeneger.shared.arrayTask[indexPath.row].statusTask = true
            self?.dataSource[indexPath.row].statusTask = true
            self?.filterTask()
            self?.taskTableView.reloadData()
            success(true)
        }
        
        swipeComplited.image = #imageLiteral(resourceName: "icons8-task-completed-64")
        swipeComplited.backgroundColor = .green
        if indexPath.section == 0 {
            let configurate = UISwipeActionsConfiguration(actions: [swipe, swipeComplited])
            configurate.performsFirstActionWithFullSwipe = false
            return configurate
        } else {
            let configurate = UISwipeActionsConfiguration(actions: [swipe])
            configurate.performsFirstActionWithFullSwipe = false
            return configurate
        }
    }
}
extension TasksViewController: TaskTableViewDelegate {
    func didTappedOnButton(from cell: MyTaskCell) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "create") as! CreateTaskViewController
        vc.index = taskTableView.indexPath(for: cell)!.row
        vc.saveAndCreate = false
        navigationController?.pushViewController(vc, animated: true)
    }
}
