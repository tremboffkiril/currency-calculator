//
//  RestCurrency.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 28.11.2019.
//

import UIKit
import Alamofire

class RestCurrency: RestBase {
    fileprivate var params: [String: Any] = [:]
    fileprivate var path: String = ""
    
    //MARK: - Profile
    
    func curencies(currency: String,
                 sender: UIViewController?,
                 callback: @escaping (Result<ResultArrayModel<CurrencyModel>?, ErrorModel?>)->Void) {

        path = RestSuffix.getPath(.suffix_last_prices) + "/" + currency

        call(model: ResultArrayModel<CurrencyModel>.self,
             method: .get,
             path: path,
             loader: true,
             sender: sender?.name) { (result) in
                callback(result)
        }
    }
}


