//
//  OptionTVCell.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit

class OptionTVCell: UITableViewCell {
    
    let backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray2
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let repeatSwitch: UISwitch = {
        let swich = UISwitch()
        swich.isOn = true
        swich.isHidden = true
        swich.addTarget(self, action: #selector(swichChange(paramTarget:)), for: .valueChanged)
        swich.translatesAutoresizingMaskIntoConstraints = false
        return swich
    }()
    
    let nameCellLabel = UILabel(text: "", font: UIFont(name: "GillSans-Bold", size: 15), alignment: .center, color: .black)
    
    weak var switchReapetDelegate: SwitchReapetProtocol?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellScheduleConfigure(nameArray: [[String]],indexPath: IndexPath, hexColor: String) {
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
        
        let color = UIColor().colorFromHex(hexColor)
        backgroundViewCell.backgroundColor = (indexPath.section == 3 ? color : .white)
        
        repeatSwitch.isHidden = (indexPath.section == 4 ? false : true)
        repeatSwitch.onTintColor = .blue
    }
    
    func cellTasksConfigure(nameAray: [String],indexPath: IndexPath, hexColor: String) {
        nameCellLabel.text = nameAray[indexPath.section]
        let color = UIColor().colorFromHex(hexColor)
        backgroundViewCell.backgroundColor = (indexPath.section == 3 ? color: .white)
    }
    
    func cellContactsConfigure(nameAray: [String],indexPath: IndexPath) {
        nameCellLabel.text = nameAray[indexPath.section]

        indexPath.section == 4 ? backgroundViewCell.image = UIImage(systemName: "person.fill.badge.plus") : nil
    }

    
    @objc private func swichChange(paramTarget: UISwitch) {
        switchReapetDelegate?.switchReapet(value: paramTarget.isOn)
    }
    
    private func setupView() {
        
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(backgroundViewCell)
        nameCellLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewCell.addSubview(nameCellLabel)
        contentView.addSubview(repeatSwitch)
        
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
           
            backgroundViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            
            nameCellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            repeatSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            repeatSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
        ])
    }
    
}
