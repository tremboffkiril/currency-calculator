//
//  UICollectionViewExtensions.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 28.11.2019.
//

import Foundation
import UIKit
import Differ

extension UICollectionView {
    func reloadChanges<T: Collection>(from old: T, to new: T) where T.Element: Equatable {
        animateItemChanges(oldData: old, newData: new)
    }
}
