//
//  ScheduleOptionTVC.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit

class ScheduleOptionTVC: UITableViewController {
    
    let idOptionScheduleCell = "idOptionScheduleCell"
    let idOptionScheduleHeder = "idOptionScheduleHeder"
    
    let headerNameArray = ["DATE AND TIME", "LESSON", "TEACHER", "COLOR", "PERIOD"]
    
    let cellNameArray = [["Date", "Time"],
                         ["Name", "Type", "Building", "Audience"],
                         ["Teacher Name"],
                         ["", ""],
                         ["Repeat every 7 days"],]
    
    private var scheduleModel = ScheduleModel()
    
    var hexColorCell = "FFFFFF"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Option Schedule"
        setDelegate()
        setupView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTap))
        
    }
    
    @objc private func saveButtonTap() {
        scheduleModel.scheduleColor = hexColorCell
        RealmManager.shared.saveScheduleModel(model: scheduleModel)
        scheduleModel = ScheduleModel()
        alertOk(title: "Success")
        hexColorCell = "FFFFFF"
//        tableView.reloadRows(at: [[0,0],[0,1],[1,0],[1,1],[1,2],[1,3],[2,0]], with: .none)
        tableView.reloadData()
        
    }
    
    
    private func setupView() {
        
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.register(OptionTVCell.self, forCellReuseIdentifier: idOptionScheduleCell)
        tableView.register(OptionHTCell.self, forHeaderFooterViewReuseIdentifier: idOptionScheduleHeder)
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 4
        case 2: return 1
        case 3: return 1
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionScheduleCell, for: indexPath) as! OptionTVCell
        cell.selectionStyle = .none
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        cell.switchReapetDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionScheduleHeder) as! OptionHTCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionTVCell
        
        switch indexPath {
        case [0,0]:
            alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
                    self.scheduleModel.scheduleDate = date
                    self.scheduleModel.scheduleWeekday = numberWeekday
            }
        case [0,1]:
            alertTime(label: cell.nameCellLabel) { (time) in
                self.scheduleModel.scheduleTime = time
            }
        case [1,0]:
            alertCellName(label: cell.nameCellLabel, name: "Name Lesson", placeHolder: "Enter name lesson") { text in
                self.scheduleModel.scheduleName = text
            }
        case [1,1]:
            alertCellName(label: cell.nameCellLabel, name: "Type lesson", placeHolder: "Enter type lesson") { text in
                self.scheduleModel.scheduleType = text
            }
        case [1,2]:
            alertCellName(label: cell.nameCellLabel, name: "Building number", placeHolder: "Enter type lesson") { text in
                self.scheduleModel.scheduleBuilding = text
            }
        case [1,3]:
            alertCellName(label: cell.nameCellLabel, name: "Building number", placeHolder: "Enter type lesson") { text in
                self.scheduleModel.scheduleAudience = text
            }
        case [2,0]: pushController(vc: ContactsTicherVC())
        case [3,0]: pushController(vc: ScheduleColorVC())
        default: print("ok")
        }
        
        func pushController(vc: UIViewController) {
            let viewController = vc
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension ScheduleOptionTVC: SwitchReapetProtocol {
    func switchReapet(value: Bool) {
        scheduleModel.scheduleReapet = value
    }

}
