//
//  TabBarVC.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()

        
    }
    
    func setupTabBar() {
        
        let scheduleVC = createNavController(vc: ScheduleVC(), itemsName: "Schedule", itemsImage: "calendar")
        let tasksVC = createNavController(vc: TasksVC(), itemsName: "Tasks", itemsImage: "text.badge.checkmark")
        let contactsVC = createNavController(vc: ContactsVC(), itemsName: "Contacts", itemsImage: "person.crop.square")
        
        viewControllers = [scheduleVC, tasksVC, contactsVC]
    }
    
    func createNavController(vc: UIViewController, itemsName: String, itemsImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemsName, image: UIImage(systemName: itemsImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 20)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        return navController
        
    }
}
