//
//  RestError.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import Foundation

enum Result<Model: Decodable, Error: Decodable> {
    case success(Model)
    case failed(Error)
}
