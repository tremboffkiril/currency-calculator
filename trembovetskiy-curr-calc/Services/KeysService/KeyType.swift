//
//  KeyType.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import Foundation

enum KeyType {
    
    static var hostURL: String {
        return KeysService.shared.string(key: "HOST_Url")!
    }
    
    static var apiURL: String {
        return KeysService.shared.string(key: "API_Url")!
    }
    
    static var apiScheme: String {
        return KeysService.shared.string(key: "API_Scheme")!
    }
}
