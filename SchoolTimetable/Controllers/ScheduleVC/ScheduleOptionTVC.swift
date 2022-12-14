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
    
    var cellNameArray = [["Date", "Time"],
                         ["Name", "Type", "Building", "Audience"],
                         ["Teacher Name"],
                         ["", ""],
                         ["Repeat every 7 days"],]
    
    var scheduleModel = ScheduleModel()
    
    var hexColorCell = "FFFFFF"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Option Schedule"
        setDelegate()
        setupView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTap))
        
    }
    
    private func animateTableView() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableViewWidth = tableView.frame.width
        var delay = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: -tableViewWidth, y: 0)
            
            UIView.animate(withDuration: 1.5,
                           delay: Double(delay) * 0.1,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                cell.transform = CGAffineTransform.identity
            },
                           completion: nil)
            delay += 1
        }
    }
    
    @objc private func saveButtonTap() {
        
        if scheduleModel.scheduleDate == nil || scheduleModel.scheduleTime == nil || scheduleModel.scheduleName == "Unknown" {
            alertOk(title: "Error", message: "Required fileds: DATE, TIME, NAME")
        } else {
            scheduleModel.scheduleColor = hexColorCell
            RealmManager.shared.saveScheduleModel(model: scheduleModel)
            scheduleModel = ScheduleModel()
            alertOk(title: "Success", message: nil)
            hexColorCell = "FFFFFF"
            cellNameArray[2][0] = "Teacher Name"
            tableView.reloadData()
        }
        
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
        case [2,0]: pushController(vc: ContactsTicherTVC())
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
