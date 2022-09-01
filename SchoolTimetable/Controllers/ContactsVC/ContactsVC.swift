//
//  ContactsVC.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit
import RealmSwift

class ContactsVC: UIViewController {
    
    let searchController = UISearchController()
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = .zero
        return tableView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Friends", "Teachers"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedChanged), for: .valueChanged)
        return segmentControl
    }()
    
    let idContactCell = "idContactCell"
    
    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactsModel>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        setupView()
        setConstraints()
        setDelegate()
        
        contactsArray = localRealm.objects(ContactsModel.self).filter("contactsType = 'Friend'")
    }
    
    private func setupView() {
        
        title = "Contacts"
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        tableView.register(ContactsTVCell.self, forCellReuseIdentifier: idContactCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addButtonTap))
    }
    
    @objc private func segmentedChanged() {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            contactsArray = localRealm.objects(ContactsModel.self).filter("contactsType = 'Friend'")
            tableView.reloadData()
        } else {
            contactsArray = localRealm.objects(ContactsModel.self).filter("contactsType = 'Teacher'")
            tableView.reloadData()
        }
    }

@objc private func addButtonTap() {
    let contactsOptionTBV = ContactsOptionTVC()
    navigationController?.pushViewController(contactsOptionTBV, animated: true)
}
    
    private func setDelegate() {
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}


extension ContactsVC: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactCell, for: indexPath) as! ContactsTVCell
        let model = contactsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ok")
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = contactsArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContactsModel(model: editingRow)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ContactsVC {
    
    private func setConstraints() {
        
        
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView], axis: .vertical, spacing: 0, distributiom: .equalSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}
