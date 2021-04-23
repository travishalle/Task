//
//  Task.swift
//  Task
//
//  Created by Travis Halle on 4/21/21.
//

import Foundation

class Task: Codable {
    
    //MARK: Properties
    var taskName: String
    var taskNotes: String
    var dueDate: Date
    var isComplete: Bool
    let uuid: String
    
    //MARK: Properties
    init(taskName: String, taskNotes: String = "", dueDate: Date = Date(), isComplete: Bool = false, uuid : String = UUID().uuidString) {
        self.taskName = taskName
        self.taskNotes = taskNotes
        self.dueDate = dueDate
        self.isComplete = isComplete
        self.uuid = uuid
    }
}//End of class


//MARK: Extensions
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
