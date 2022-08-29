//
//  ContactsOptionTVC.swift
//  SchoolTimetable
//
//  Created by Test on 29/08/22.
//


import UIKit

class ContactsOptionTVC: UITableViewController {
    
    let idContcactsOptionCell = "idContcactsOptionCell"
    let idContcactsOptionHeader = "idContcactsOptionHeader"
    
    let headerNameArray = ["NAME", "PHONE", "MAIL", "TYPE", "CHOOSE IMAGE"]
    
    let cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Option Schedule"
        setDelegate()
        setupView()
    }
    
    
    private func setupView() {
        
        tableView.backgroundColor = .systemGray5
        tableView.separatorStyle = .none
        tableView.register(OptionTVCell.self, forCellReuseIdentifier: idContcactsOptionCell)
        tableView.register(OptionHTCell.self, forHeaderFooterViewReuseIdentifier: idContcactsOptionHeader)
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContcactsOptionCell, for: indexPath) as! OptionTVCell
        cell.selectionStyle = .none
        cell.cellContactsConfigure(nameAray: cellNameArray, indexPath: indexPath)
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idContcactsOptionHeader) as! OptionHTCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionTVCell

        switch indexPath.section {
        case 0: alertCellName(label: cell.nameCellLabel, name: "Name Contact", placeHolder: "Enter Name Contact") { text in
            print(text)
        }
        case 1: alertCellName(label: cell.nameCellLabel, name: "Phone number", placeHolder: "Enter Name Contact") { text in
            print(text)
        }
        case 2: alertCellName(label: cell.nameCellLabel, name: "Mail", placeHolder: "Enter Name Contact") { text in
            print(text)
        }
        case 3: alertOfTeacher(label: cell.nameCellLabel) { type in
            print(type)
        }
        case 4: alertPhotoCamera(label: cell.nameCellLabel) { source in
//            chooseImagePicker(source: source)
        }
        default:
            print("OK")
        }
            
            func pushController(vc: UIViewController) {
                let viewController = vc
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
}


extension ContactsTVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let cell = tableView.cellForRow(at: [4,0]) as! OptionTVCell
        
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        dismiss(animated: true)
    }
}
