//
//  Task+CoreDataClass.swift
//  To-do list app
//
//  Created by ZhZinekenov on 11.08.2023.
//
//

import Foundation
import CoreData

let currentDate = Date()
let calendar = Calendar.current

func isDateToday(_ date: Date) -> Bool {
    return calendar.isDateInToday(date)
}
@objc(Task)
public class Task: NSManagedObject {
    var finalTitle: String {
        return title ?? ""
    }
    
    var timeUpdated: String {
        if isDateToday(lastUpdated!) {
            return lastUpdated!.formatted(date: .omitted, time: .shortened)
        } else {
            return lastUpdated!.formatted(date: .abbreviated, time: .shortened)
        }
    }
}
