//
//  LoaderService.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import UIKit

/// Manager for show/hide loader
class LoaderService {
    
    /// Loader view
    var loader : LoaderView?
    
    // MARK: - SINGLETON
    static let shared: LoaderService = {
        let instance = LoaderService()
        return instance
    }()
    
    // MARK: - Functions for loader
    
    /// Show view with create Loader View, added constraints
    func showView() {
        DispatchQueue.main.async {
            if UIApplication.shared.keyWindow != nil {
                if self.loader == nil {
                    self.loader = LoaderView.loadFromXib()
                    self.loader?.loadView()
                    self.loader?.addedConstraints()
                }
                
                self.loader?.showView()
            }
        }
    }
    
    /// Hide view if all Rest Calls finished
    /// Except Background calls
    func hideView() {
        RestBase.isRequestInRunning({ (isRequest) in
            if !isRequest {
                DispatchQueue.main.async {
                    self.loader?.hideView()
                }
            }
        })
    }
}
