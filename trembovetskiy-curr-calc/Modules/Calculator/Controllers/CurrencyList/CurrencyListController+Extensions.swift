//
//  CurrencyListController+Extensions.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 25.11.2019.
//

import Foundation
import UIKit
import DropDown

// MARK: - Extension for controller fucntionality

extension CurrencyListController {
    
    // MARK: - Setup UI + Setup Settings
    
    func setup() {
        updateCurrentCurrencyView()
        
        collectionView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: collectionView.frame.width / 2 - 30, height: collectionView.frame.width / 2 - 30)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
        
        currencyListDropDown.direction = .bottom
        currencyListDropDown.anchorView = currencyView
        currencyListDropDown.bottomOffset = CGPoint(x: 0, y: currencyView.bounds.height)
        
        currencyListDropDown.dataSource = ["USD", "EUR", "GBP"]
        currencyListDropDown.selectionAction = { (index: Int, item: String) in
            self.updateCurrentCurrencyView(show: false)
            self.currentCurrencyLabel.text = item
            self.timer.invalidate()
            CurrencyService.shared.saveCurrencyToLocal(currency: item)
            self.getCurrencies(currency: item, reloadTimer: true)
        }
        CurrencyService.shared.checkChoosedCurrency()
        currentCurrencyLabel.text = CurrencyService.shared.getChoosedCurrency()
    }
    
    // MARK: - Update Currency Top View
    
    func updateCurrentCurrencyView(show: Bool? = nil) {
        showDropDown = show ?? showDropDown
        showHideListImageView.image = UIImage(named: (showDropDown ? "ic_show_currency_list" : "ic_hide_currency_list"))
    }
    
    // MARK: - Setup Timer Methods
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }

    @objc func updateCounting(){
        getCurrencies(currency: CurrencyService.shared.getChoosedCurrency())
    }
}

// MARK: - Extension for Collection View Methods of UICollectionViewDelegate and UICollectionViewDataSource

extension CurrencyListController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        cell.update(currency: currencies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let calculatorController = UIStoryboard(name: "Calculator", bundle: nil).instantiateViewController(identifier: "CalculatorController") as! CalculatorController
        calculatorController.currency = currencies[indexPath.row]
        self.navigationController?.pushViewController(calculatorController, animated: true)
    }
}
