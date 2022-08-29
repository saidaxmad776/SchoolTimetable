//
//  ScheduleColorVC.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit

class ScheduleColorVC: UITableViewController {
    
    let idScheduleColorCell = "idScheduleColorCell"
    let idOptionsHeder = "idOptionScheduleHeder"
    
    let headerNameArray = ["1", "2", "3", "4", "5", "6", "7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Color Schedule"
        setDelegate()
        setupView()
    }
    
    
    private func setupView() {
        
        tableView.backgroundColor = .systemGray5
        tableView.separatorStyle = .none
        tableView.register(ColorTVCell.self, forCellReuseIdentifier: idScheduleColorCell)
        tableView.register(OptionHTCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeder)
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idScheduleColorCell, for: indexPath) as! ColorTVCell
        cell.selectionStyle = .none
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeder) as! OptionHTCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
        case 0: setColor(color: "511307")
        case 1: setColor(color: "851C0D")
        case 2: setColor(color: "BE2813")
        case 3: setColor(color: "EC3C1A")
        case 4: setColor(color: "EF5931")
        case 5: setColor(color: "F07F5A")
        case 6: setColor(color: "F4A88B")
        default: setColor(color: "FFFFFF")
        }
    }
    
    private func setColor(color: String) {
        let scheduleOption = self.navigationController?.viewControllers[1] as? ScheduleOptionTVC
        scheduleOption?.hexColorCell = color
        scheduleOption?.tableView.reloadRows(at: [[3,0], [4,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
}
