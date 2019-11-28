//
//  RestMethod.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import UIKit
import Alamofire

public enum RestMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
    
    static func toAlamofile(_ method: RestMethod) -> HTTPMethod {
        switch method {
        case options:
            return .options
        case get:
            return .get
        case head:
            return .head
        case post:
            return .post
        case put:
            return .put
        case patch:
            return .patch
        case delete:
            return .delete
        case trace:
            return .trace
        case connect:
            return .connect
        }
    }
}

