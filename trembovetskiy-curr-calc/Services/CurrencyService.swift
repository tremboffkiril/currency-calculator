//
//  CurrencyService.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 28.11.2019.
//

import Foundation
import UIKit

class CurrencyService {
    
    static let shared: CurrencyService = {
        let instance = CurrencyService()
        return instance
    }()
    
    func saveCurrencyToLocal(currency: String) {
        UserDefaults.standard.set(currency, forKey: "choosedCurrency")
    }
       
    func getChoosedCurrency() -> String {
        if let currency = UserDefaults.standard.string(forKey: "choosedCurrency") {
            return currency
        } else {
            return "USD"
        }
    }
          
    func checkChoosedCurrency() {
        if UserDefaults.standard.string(forKey: "choosedCurrency") == nil {
            UserDefaults.standard.set("USD", forKey: "choosedCurrency")
        }
    }
}
