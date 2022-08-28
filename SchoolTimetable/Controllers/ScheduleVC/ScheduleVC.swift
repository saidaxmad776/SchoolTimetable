//
//  ScheduleVC.swift
//  SchoolTimetable
//
//  Created by Test on 27/08/22.
//

import UIKit
import FSCalendar

class ScheduleVC: UIViewController {
    
    var calendarHeightConstraints: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.scope = .week
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()

    let showHideButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray2
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 15
        button.tintColor = .black
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.addTarget(self, action: #selector(showHideTapBTN), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        swipeAction()
        setDelegate()
        
        if #available(iOS 15.0, *) {
            navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
        }
    }
    
    @objc private func showHideTapBTN() {
        
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setImage(UIImage(systemName: "chevron.compact.up"), for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        }
    }
    
    //        MARK: - Swipe Gestore Recognizer
    
    private func swipeAction() {
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
        
    }
    
    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .up:
            showHideTapBTN()
        case .down:
            showHideTapBTN()
        default:
            break
        }
    }
    
}

extension ScheduleVC {
    
    private func setupView() {
        
        title = "Schedule"
        view.backgroundColor = .systemGray6
        
        view.addSubview(calendar)
        calendarHeightConstraints = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraints)

        view.addSubview(showHideButton)
    }
    
    private func setDelegate() {

//        tableView.delegate = self
//        tableView.dataSource = self
        
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    private func setConstraints() {
        

        
        NSLayoutConstraint.activate([
            

            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            showHideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            showHideButton.heightAnchor.constraint(equalToConstant: 20),
//
//            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }

}
//        MARK: - FSCalendarDataSource, FSCalendarDelegate
extension ScheduleVC: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraints.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
}
