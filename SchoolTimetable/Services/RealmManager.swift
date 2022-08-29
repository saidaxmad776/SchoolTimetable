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
}
