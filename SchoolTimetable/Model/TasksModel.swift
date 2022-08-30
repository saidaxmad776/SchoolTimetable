//
//  TasksModel.swift
//  SchoolTimetable
//
//  Created by Test on 30/08/22.
//

import Foundation
import RealmSwift

class TasksModel: Object {
    
    @Persisted var taskDate: Date?
    @Persisted var taskName: String = "Unknown"
    @Persisted var taskDescription: String = "Unknown"
    @Persisted var taskColor: String = "1A4766"
    @Persisted var taskReady: Bool = false

}
