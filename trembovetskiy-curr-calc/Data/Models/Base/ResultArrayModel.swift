//
//  ResultArrayModel.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import Foundation

class ResultArrayModel<Model: Decodable>: RestAPIModel, Decodable {
    var data: [Model]?
}

