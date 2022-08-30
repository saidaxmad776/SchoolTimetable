//
//  ScheduleVC.swift
//  SchoolTimetable
//
//  Created by Test on 27/08/22.
//

import UIKit
import FSCalendar
import RealmSwift

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
    
    private let idScheduleCell = "idScheduleCell"
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = .zero
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let localRealm = try! Realm()
    var scheduleArray: Results<ScheduleModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        swipeAction()
        setDelegate()
        
        scheduleOnDay(date: Date())
        
        if #available(iOS 15.0, *) {
            navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTap))
        }
    }
    
    @objc private func addButtonTap() {
        let scheduleOptionTVC = ScheduleOptionTVC()
        navigationController?.pushViewController(scheduleOptionTVC, animated: true)
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
        
        view.addSubview(tableView)
        tableView.register(ScheduleTVCell.self, forCellReuseIdentifier: idScheduleCell)
    }
    
    private func setDelegate() {

        tableView.delegate = self
        tableView.dataSource = self
        
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    private func scheduleOnDay(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return }
        print(weekday)
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let predicatRepeat = NSPredicate(format: "scheduleWeekday = \(weekday) AND scheduleReapet = true")
        let predicateUnrepeat = NSPredicate(format: "scheduleReapet = false AND scheduleDate BETWEEN %@",
                                            [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicatRepeat, predicateUnrepeat])
        
        scheduleArray = localRealm.objects(ScheduleModel.self).filter(compound).sorted(byKeyPath: "scheduleTime")
        tableView.reloadData()
    }

}
//        MARK: - FSCalendarDataSource, FSCalendarDelegate
extension ScheduleVC: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraints.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        scheduleOnDay(date: date)
    }
}

extension ScheduleVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idScheduleCell, for: indexPath) as! ScheduleTVCell
        cell.selectionStyle = .none
        
        let model = scheduleArray[indexPath.row]
        cell.configureModel(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = scheduleArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteScheduleModel(model: editingRow)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
  
}

extension ScheduleVC {
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            showHideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            showHideButton.heightAnchor.constraint(equalToConstant: 20),
            
            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }
}
