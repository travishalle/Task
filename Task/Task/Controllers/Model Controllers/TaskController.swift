//
//  TaskController.swift
//  Task
//
//  Created by Travis Halle on 4/21/21.
//

import Foundation

class TaskController {
    
    //MARK: Properties
    static let sharedInstance = TaskController ()
    var tasks: [Task] = []
    
    //MARK: Functions
    //Create
    func createTaskWith(taskName: String, taskNotes: String, dueDate: Date) {
        let newTask = Task(taskName: taskName, taskNotes: taskNotes, dueDate: dueDate)
        tasks.append(newTask)
        TaskController.sharedInstance.saveToPersistenceStore()
    }
    
    //Update
    func updateTask(task: Task, newName: String, newNotes: String, newDueDate: Date) {
        task.taskName = newName
        task.taskNotes = newNotes
        task.dueDate = newDueDate
        TaskController.sharedInstance.saveToPersistenceStore()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        TaskController.sharedInstance.saveToPersistenceStore()
    }
    
    //Delete
    func delete(taskToDelete: Task) {
        guard let index = tasks.firstIndex(of: taskToDelete) else {return}
        tasks.remove(at: index)
        TaskController.sharedInstance.saveToPersistenceStore()
    }
    
    //MARK: JSON Persistence
    func createPersistenceStore() -> URL{
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Tasks.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: createPersistenceStore())
        } catch {
            print ("Error in \(#function) : \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch{
            print ("Error in \(#function) : \(error.localizedDescription)")
        }
    }
}//End of class
