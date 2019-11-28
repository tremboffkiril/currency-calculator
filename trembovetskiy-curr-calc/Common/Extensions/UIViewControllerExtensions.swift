//
//  UIViewControllerExtensions.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 28.11.2019.
//

import Foundation
import UIKit

extension UIViewController {

/// Get name view controller
    var name: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
