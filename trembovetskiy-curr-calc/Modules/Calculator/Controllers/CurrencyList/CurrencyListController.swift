//
//  CurrencyListController.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 25.11.2019.
//

import UIKit
import DropDown

class CurrencyListController: UIViewController {

    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var showHideListImageView: UIImageView!
    @IBOutlet weak var currentCurrencyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let currencyListDropDown = DropDown()
    var showDropDown = Bool()
    var currencies: [CurrencyModel] = []
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCurrencies(currency: CurrencyService.shared.getChoosedCurrency(), reloadTimer: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    @IBAction func showCurrencyListAction(_ sender: Any) {
        showDropDown = !showDropDown
        updateCurrentCurrencyView()
        if showDropDown {
            currencyListDropDown.show()
        } else {
            currencyListDropDown.hide()
        }
    }
}
