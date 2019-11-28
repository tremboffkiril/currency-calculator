//
//  CurrencyListController+Data.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 28.11.2019.
//

import Foundation
import UIKit
import Toaster

// MARK: - Extension for API Data

extension CurrencyListController {
    func getCurrencies(currency: String, reloadTimer: Bool? = nil) {
        RestCurrency().curencies(currency: currency,
                                 sender: self) { (result) in
                                    switch result {
                                    case .success(let model):
                                        if let currencies = model?.data {
                                            let oldCurrencies = self.currencies
                                            self.currencies = currencies
                                            self.collectionView.reloadChanges(from: oldCurrencies, to: self.currencies)
                                        }
                                    case .failed(let error):
                                        Toast(text: error?.error ?? "Something went wrong, please try again!").show()
                                    }
                                    if let reload = reloadTimer, reload {
                                        self.scheduledTimerWithTimeInterval()
                                    }
        }
    }
}
