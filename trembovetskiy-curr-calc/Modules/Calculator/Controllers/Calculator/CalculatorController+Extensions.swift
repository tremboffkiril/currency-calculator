//
//  CalculatorController+Extensions.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 28.11.2019.
//

import Foundation
import UIKit

extension CalculatorController {
    
    func setup() {
        inputCountTextField.becomeFirstResponder()
        inputCountTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        updateUI()
        covert(text: "1")
    }
    
    func updateUI() {
        tradePairLabel.text = (isChangeDirection ? "\(CurrencyService.shared.getChoosedCurrency()) / \(currency?.symbol1 ?? "")" : "\(currency?.symbol1 ?? "-") / \(CurrencyService.shared.getChoosedCurrency())")
        
        firstCurrenyLabel.text =  (isChangeDirection ? currency?.symbol1 ?? "-" : CurrencyService.shared.getChoosedCurrency())
        secondCurrencyLabel.text = (isChangeDirection ? CurrencyService.shared.getChoosedCurrency() : currency?.symbol1 ?? "-")
        oneItemPriceLabel.text = (isChangeDirection ? "\(1 / (Double(currency?.lprice ?? "0") ?? 0))" : currency?.lprice ?? "0")
    }
    
    func covert(text: String) {
        if let intPricePerOne = Double(currency?.lprice ?? "0"), let currentCount = Double(text) {
            resultSummLabel.text = (isChangeDirection ? "\(intPricePerOne / currentCount)" : "\(intPricePerOne * currentCount)") 
        } else {
            resultSummLabel.text = "0"
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        covert(text: textField.text ?? "1")
    }
}
