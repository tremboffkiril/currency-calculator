//
//  CalculatorController.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 25.11.2019.
//

import UIKit

class CalculatorController: UIViewController {
    
    @IBOutlet weak var tradePairLabel: UILabel!
    @IBOutlet weak var oneItemPriceLabel: UILabel!
    @IBOutlet weak var firstCurrenyLabel: UILabel!
    @IBOutlet weak var secondCurrencyLabel: UILabel!
    @IBOutlet weak var inputCountTextField: UITextField!
    @IBOutlet weak var resultSummLabel: UILabel!
    
    var currency: CurrencyModel?
    var isChangeDirection = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func swapConverterAction(_ sender: Any) {
        isChangeDirection = !isChangeDirection
        updateUI()
        covert(text: inputCountTextField.text ?? "1")
    }
}

