//
//  ScheduleModel.swift
//  SchoolTimetable
//
//  Created by Test on 29/08/22.
//

import RealmSwift
import Foundation

class ScheduleModel: Object {
    
    @Persisted var scheduleDate: Date?
    @Persisted var scheduleTime: Date?
    @Persisted var scheduleName: String = "Unknown"
    @Persisted var scheduleType: String = "Unknown"
    @Persisted var scheduleBuilding: String = "Unknown"
    @Persisted var scheduleAudience: String = "Unknown"
    @Persisted var scheduleTeacher: String = "Unknown"
    @Persisted var scheduleColor: String = "FFFFFF"
    @Persisted var scheduleReapet: Bool = true
    @Persisted var scheduleWeekday: Int = 1
    
}
