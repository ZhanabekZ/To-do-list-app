//
//  ViewController + TableView.swift
//  To-do list app
//
//  Created by ZhZinekenov on 09.08.2023.
//

import Foundation
import UIKit
import CoreData

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        if let task = fetchedResultsController?.object(at: indexPath) {
            cell.setup(task: task)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let task = fetchedResultsController?.object(at: indexPath) {
            task.completed.toggle()
            appDelegate.saveContext()
            
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = task.completed ? .checkmark : .none
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tasks = fetchedResultsController?.sections?[section] {
            return tasks.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let task = fetchedResultsController?.object(at: indexPath) {
                appDelegate.deleteTask(task)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

