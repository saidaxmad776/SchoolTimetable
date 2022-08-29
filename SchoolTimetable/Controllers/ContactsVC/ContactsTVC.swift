//
//  ContactsVC.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit

class ContactsTVC: UITableViewController {
    
    let idContactCell = "idContactCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        setupView()
        setConstraints()
        setDelegate()
    }
    
    private func setupView() {
        
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
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactCell, for: indexPath) as! ContactsTVCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ok")
    }
}

extension ContactsTVC {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            

        ])
    }
}
