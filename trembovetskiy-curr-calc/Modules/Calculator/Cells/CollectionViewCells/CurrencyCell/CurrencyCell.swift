//
//  CurrencyCell.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 28.11.2019.
//

import UIKit

class CurrencyCell: UICollectionViewCell {

    @IBOutlet weak var currencyValueLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension CurrencyCell {
    func update(currency: CurrencyModel) {
        currencyValueLabel.text = currency.lprice ?? "-"
        currencyNameLabel.text = currency.symbol1 ?? "-"
    }
}
