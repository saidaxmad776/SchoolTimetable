//
//  ContactsTVCell.swift
//  SchoolTimetable
//
//  Created by Test on 29/08/22.
//

import UIKit

class ContactsTVCell: UITableViewCell {
    
    let contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone.fill.badge.plus")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope.badge")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel = UILabel(text: "Name Person",
                            font: UIFont(name: "GillSans-Bold", size: 15), alignment: .left, color: .black)
    let phoneNumber = UILabel(text: "+9989 901114100",
                            font: UIFont(name: "GillSans-Bold", size: 15), alignment: .left, color: .black)
    let mailLabel = UILabel(text: "name@gmail.com",
                            font: UIFont(name: "GillSans-Bold", size: 15), alignment: .left, color: .black)
    
    private var stackViewLabel = UIStackView()
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ContactsModel) {
        
        nameLabel.text = model.contactsName
        phoneNumber.text = model.contactsPhone
        mailLabel.text = model.contactsMail
        
        if let data = model.contactsImage, let image = UIImage(data: data) {
            contactImageView.image = image
        } else {
            contactImageView.image = UIImage(systemName: "person")
        }
        
        
    }

    
    private func setupView() {
        selectionStyle = .none
        
        addSubview(contactImageView)
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewLabel = UIStackView(arrangedSubviews: [phoneImageView, phoneNumber, mailImageView, mailLabel], axis: .horizontal, spacing: 2, distributiom: .equalSpacing)
        
        addSubview(stackViewLabel)
        stackViewLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            contactImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            contactImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            contactImageView.widthAnchor.constraint(equalToConstant: 70),
            contactImageView.heightAnchor.constraint(equalToConstant: 70),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 21),
            
            stackViewLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            stackViewLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            stackViewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackViewLabel.heightAnchor.constraint(equalToConstant: 21),
            
        ])
    }
    
}

