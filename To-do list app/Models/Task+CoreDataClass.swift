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
let dateFormatter = DateFormatter()

func isDateToday(_ date: Date) -> Bool {
    return calendar.isDateInToday(date)
}
func isDateThisYear(_ date: Date) -> Bool {
    return calendar.isDate(date, equalTo: Date(), toGranularity: .year)
}
@objc(Task)
public class Task: NSManagedObject {
    var finalTitle: String {
        return title ?? ""
    }
    
    var timeUpdated: String {
        if isDateToday(lastUpdated!) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: lastUpdated!)
        } else if isDateThisYear(lastUpdated!){
            dateFormatter.dateFormat = "MMMM dd, HH:mm"
            return dateFormatter.string(from: lastUpdated!).capitalized
        } else {
            dateFormatter.dateFormat = "YYYY MMMM dd"
            return dateFormatter.string(from: lastUpdated!)
        }
    }
}
