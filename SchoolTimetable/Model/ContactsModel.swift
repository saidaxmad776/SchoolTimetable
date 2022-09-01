//
//  ContactsModel.swift
//  SchoolTimetable
//
//  Created by Test on 30/08/22.
//

import Foundation
import RealmSwift

class ContactsModel: Object {
    
    @Persisted var contactsName = "Unknown"
    @Persisted var contactsPhone = "Unknown"
    @Persisted var contactsMail = "Unknown"
    @Persisted var contactsType = "Unknown"
    @Persisted var contactsImage: Data?

}
