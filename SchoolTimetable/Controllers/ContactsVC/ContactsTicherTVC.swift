//
//  ContactsTicherTVC.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit
import RealmSwift

class ContactsTicherTVC: UITableViewController {
    
    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactsModel>!
    private let teacherId = "teacherId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Teachers"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: teacherId)
        
        contactsArray = localRealm.objects(ContactsModel.self).filter("contactsType = 'Teacher'")
    }
    
    private func setTeacher(teacher: String) {
        let scheduleOption = self.navigationController?.viewControllers[1] as? ScheduleOptionTVC
        scheduleOption?.scheduleModel.scheduleTeacher = teacher
        scheduleOption?.cellNameArray[2][0] = teacher
        scheduleOption?.tableView.reloadRows(at: [[2,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teacherId, for: indexPath) as! ContactsTVCell
        let model = contactsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactsArray[indexPath.row]
        setTeacher(teacher: model.contactsName)
    }
}
