//
//  RestSuffix.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import Foundation

public enum RestSuffix: String {
   
    // login
    case suffix_last_prices = "last_prices" /// GET - Currencies List.
   
    /// get host url
    static public func getPath(_ suffix: RestSuffix, params: String? = nil) -> String {
        var urlComponents = URLComponents()
        urlComponents.scheme = KeyType.apiScheme
        urlComponents.host = KeyType.hostURL
        urlComponents.path = KeyType.apiURL + suffix.rawValue
        return (urlComponents.url?.absoluteString ?? "")
    }
}
