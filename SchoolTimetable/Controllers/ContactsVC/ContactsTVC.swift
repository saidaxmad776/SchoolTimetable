//
//  ContactsVC.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit
import RealmSwift

class ContactsTVC: UITableViewController {
    
    let searchController = UISearchController()
    
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
    }
    
    private func setupView() {
        
        title = "Contacts"
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        tableView.separatorInset = .zero
        tableView.register(ContactsTVCell.self, forCellReuseIdentifier: idContactCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addButtonTap))
    }
    


@objc private func addButtonTap() {
    let contactsOptionTBV = ContactsOptionTVC()
    navigationController?.pushViewController(contactsOptionTBV, animated: true)
}
    
    private func setDelegate() {
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactCell, for: indexPath) as! ContactsTVCell
        let model = contactsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ok")
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = contactsArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContactsModel(model: editingRow)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ContactsTVC {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            

        ])
    }
}
