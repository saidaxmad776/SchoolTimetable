//
//  AlertTime.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit

extension UIViewController {
    
    func alertTime(label: UILabel, completionHandler: @escaping (Date) -> Void) {
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.locale = NSLocale(localeIdentifier: "Ru_ru") as Locale
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let dateFormator = DateFormatter()
            dateFormator.dateFormat = "HH:mm"
            let timeString = dateFormator.string(from: datePicker.date)
            let timeSchedule = datePicker.date
            completionHandler(timeSchedule)
            
            label.text = timeString
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        alert.negativeWidthConstraints()
        
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
        
        present(alert, animated: true, completion: nil)
    }
}
