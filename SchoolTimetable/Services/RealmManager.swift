//
//  RealmManager.swift
//  SchoolTimetable
//
//  Created by Test on 29/08/22.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveScheduleModel(model: ScheduleModel) {
        try! localRealm.write{
            localRealm.add(model)
        }
    }
    
    func deleteScheduleModel(model: ScheduleModel) {
        try! localRealm.write{
            localRealm.delete(model)
        }
    }
    
    func saveTaskModel(model: TasksModel) {
        try! localRealm.write{
            localRealm.add(model)
        }
    }
    
    func deleteTaskModel(model: TasksModel) {
        try! localRealm.write{
            localRealm.delete(model)
        }
    }
    
    func updateReadyButtonTaskModel(task: TasksModel, bool: Bool) {
        try! localRealm.write {
            task.taskReady = bool
        }
    }
}
