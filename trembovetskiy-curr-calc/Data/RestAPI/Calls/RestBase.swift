//
//  RestBase.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import Foundation
import Alamofire

let RestAPIBackground = "Background"

class RestBase {
    
    func setup() {
        Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders?.updateValue("application/json", forKey: "Content-Type")
        Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders?.updateValue("application/json", forKey: "Accept")
    }
    
    internal func beforeCall(with loader: Bool)  {
        if loader {
            LoaderService.shared.showView()
        }
    }
    
    internal func afterCall() {
        LoaderService.shared.hideView()
    }
}

