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
        
    private var imageIsChange = false
    private var contactsModel = ContactsModel()
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self, action: #selector(saveButtonTap))
    }
    
    @objc private func saveButtonTap() {
        
        if contactsModel.contactsName == "Unknown" || contactsModel.contactsType == "Unknown" {
            alertOk(title: "Error", message: "Requered")
        } else {
            setImageModel()
            
            RealmManager.shared.saveContactsModel(model: contactsModel)
            contactsModel = ContactsModel()
            
            alertOk(title: "Success", message: nil)
            tableView.reloadData()
        }
    }
    
    @objc private func setImageModel() {
        
        if imageIsChange {
            let cell = tableView.cellForRow(at: [4,0]) as! OptionTVCell
            
            let image = cell.backgroundViewCell.image
            guard let imageData = image?.pngData() else { return }
            contactsModel.contactsImage = imageData
            
            cell.backgroundViewCell.contentMode = .scaleAspectFit
            imageIsChange = false
        } else {
            contactsModel.contactsImage = nil
        }
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
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionTVCell

        switch indexPath.section {
        case 0: alertCellName(label: cell.nameCellLabel, name: "Name Contact", placeHolder: "Enter Name Contact") { text in
            self.contactsModel.contactsName = text
        }
        case 1: alertCellName(label: cell.nameCellLabel, name: "Phone number", placeHolder: "Enter Name Contact") { text in
            self.contactsModel.contactsPhone = text
        }
        case 2: alertCellName(label: cell.nameCellLabel, name: "Mail", placeHolder: "Enter Name Contact") { text in
            self.contactsModel.contactsMail = text
        }
        case 3: alertOfTeacher(label: cell.nameCellLabel) { type in
            self.contactsModel.contactsType = type
        }
        case 4: alertPhotoCamera(label: cell.nameCellLabel) { [self] source in
            chooseImagePicker(source: source)
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

extension ContactsOptionTVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        imageIsChange = true
        dismiss(animated: true)
    }
}
