//
//  ScheduleVC.swift
//  SchoolTimetable
//
//  Created by Test on 27/08/22.
//

import UIKit
import FSCalendar

class ScheduleVC: UIViewController {
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        setDelegate()
        
        if #available(iOS 15.0, *) {
            navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
        }
    }
    
}

extension ScheduleVC {
    
    private func setupView() {
        
        title = "Schedule"
        view.backgroundColor = .systemGray6
        
        view.addSubview(calendar)

    }
    
    private func setDelegate() {

    }
    
    private func setConstraints() {
        

        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            calendar.heightAnchor.constraint(equalToConstant: 300),
//
//            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
//            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            showHideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            showHideButton.heightAnchor.constraint(equalToConstant: 20),
//
//            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }

}
