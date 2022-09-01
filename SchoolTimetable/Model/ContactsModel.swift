//
//  ContactsModel.swift
//  SchoolTimetable
//
//  Created by Test on 30/08/22.
//

import Foundation
import RealmSwift

class ContactsModel: Object {
    
    @Persisted var contactsName: String = "Unknown"
    @Persisted var contactsPhone: String = "Unknown"
    @Persisted var contactsMail: String = "Unknown"
    @Persisted var contactsType: String = "Unknown"
    @Persisted var contactsImage: Data?
}
