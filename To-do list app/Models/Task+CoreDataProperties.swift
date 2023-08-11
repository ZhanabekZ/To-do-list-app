//
//  Task+CoreDataProperties.swift
//  To-do list app
//
//  Created by ZhZinekenov on 11.08.2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var title: String?
    @NSManaged public var completed: Bool

}

extension Task : Identifiable {

}
