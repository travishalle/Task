//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Travis Halle on 4/21/21.
//

import UIKit

protocol TaskCompletionDelegate: class {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    //MARK: Properties
    weak var delegate: TaskCompletionDelegate?
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    //MARK: Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    //MARK: Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(self)
    }
    
    //MARK: Functions
    func updateViews() {
        guard let task = task, let buttonImage: UIImage = task.isComplete ? UIImage(named: "complete") : UIImage(named: "incomplete") else {return}
        taskNameLabel.text = task.taskName
        
        completionButton.setImage(buttonImage, for: .normal)
    }
}//End of class
