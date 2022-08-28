//
//  PressButtonProtocol.swift
//  SchoolTimetable
//
//  Created by Test on 28/08/22.
//

import UIKit

protocol PressReadyButtonProtocol: AnyObject {
    func readyButtonTap(indexPath: IndexPath)
}


protocol SwitchReapetProtocol: AnyObject {
    func switchReapet(value: Bool)
}
