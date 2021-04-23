//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Travis Halle on 4/21/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.sharedInstance.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell() }
        let task = TaskController.sharedInstance.tasks[indexPath.row]
        
        cell.delegate = self
        cell.task = task
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/10
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.sharedInstance.tasks[indexPath.row]
            TaskController.sharedInstance.delete(taskToDelete: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? TaskDetailViewController else {return}
            
            let taskToSend = TaskController.sharedInstance.tasks[indexPath.row]
            destinationVC.task = taskToSend
        }
    }
}//End of class


//MARK: Extension
extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        
        guard let task = sender.task else {return}
        
        TaskController.sharedInstance.toggleIsComplete(task: task)
        
        sender.updateViews()
    }
}
