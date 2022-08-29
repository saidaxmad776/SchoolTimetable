//
//  ScheduleModel.swift
//  SchoolTimetable
//
//  Created by Test on 29/08/22.
//

import RealmSwift
import Foundation

class ScheduleModel: Object {
    
    @Persisted var scheduleDate = Date()
    @Persisted var scheduleTime = Date()
    @Persisted var scheduleName: String = ""
    @Persisted var scheduleType: String = ""
    @Persisted var scheduleBuilding: String = ""
    @Persisted var scheduleAudience: String = ""
    @Persisted var scheduleTeacher: String = ""
    @Persisted var scheduleColor: String = "FFFFFF"
    @Persisted var scheduleReapet: Bool = true
    @Persisted var scheduleWeekday: Int = 1
    
}
