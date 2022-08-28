//
//  UILabel + Ext.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, alignment: NSTextAlignment, color: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = 2
    }
    
}


