//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Travis Halle on 4/21/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    var taskName = ""
    var taskNotes = ""
    var task: Task?
    var date: Date?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty,
              let taskNotes = taskNotesTextView.text, !taskNotes.isEmpty else {return}
        let date = taskDueDatePicker.date
        
        if let task = task {
            TaskController.sharedInstance.updateTask(task: task, newName: taskName, newNotes: taskNotes, newDueDate: date)
        } else {
            TaskController.sharedInstance.createTaskWith(taskName: taskName, taskNotes: taskNotes, dueDate: date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        date = taskDueDatePicker.date
    }
    
    func updateViews() {
        guard let task = task else {return}
        taskNameTextField.text = task.taskName
        taskNotesTextView.text = task.taskNotes
    }
}//End of class
