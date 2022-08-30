//
//  TasksTVCell.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit

class TasksTVCell: UITableViewCell {
    
    private let tasksName = UILabel(text: "Lesson",
                                    font: UIFont(name: "GillSans-Bold", size: 15), alignment: .left, color: .black)
    
    private let tasksDescription = UILabel(text: "Name tasks",
                                           font: UIFont(name: "GillSans-Bold", size: 15), alignment: .left, color: .black)

    private let readyButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(readyButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var cellTaskDelegate: PressReadyButtonProtocol?
    var index: IndexPath?
    
    private var stackViewLabel = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func readyButtonTap() {
        guard let index = index else { return }

        cellTaskDelegate?.readyButtonTap(indexPath: index)
    }
    
    private func setupView() {
        
        contentView.addSubview(readyButton)
        
        stackViewLabel = UIStackView(arrangedSubviews: [tasksName, tasksDescription],
                                     axis: .vertical, spacing: 10, distributiom: .fillEqually)
        addSubview(stackViewLabel)
        
    }
    
    func configure(model: TasksModel) {
        
        tasksName.text = model.taskName
        tasksDescription.text = model.taskDescription
        backgroundColor = UIColor().colorFromHex("\(model.taskColor)")
        
        if model.taskReady {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        } else {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            readyButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalToConstant: 40),
            readyButton.widthAnchor.constraint(equalToConstant: 40),
            
            stackViewLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackViewLabel.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: 20),
        ])
    }
    
}
