//
//  LoaderView.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import UIKit

/// Loader for LoaderManage
class LoaderView: UIView {
    
    /// Center view with indicator loader
    @IBOutlet weak var centerView: UIView!
    
    /// Indicator loader
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    /// Status is show loader
    var isShowLoader: Bool = false
    
    /// Return LoaderView from xib
    ///
    /// - parameter bundle: bundle for search. Default nil
    ///
    /// - returns: object LoaderView
    class func loadFromXib(_ bundle : Bundle? = nil) -> LoaderView? {
        return UINib(
            nibName: "LoaderView",
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? LoaderView
    }
    
    /// Configure view and start animation
    func configureView() {
        layoutIfNeeded()
        centerView.layer.cornerRadius = 10.0
        centerView.clipsToBounds = true
        activityIndicatorView.startAnimating()
    }
    
    /// Added constraints for view
    func addedConstraints() {
        
        if let superview = self.superview {
            let sizeFrame: CGFloat = 80.0
            let width = UIScreen.main.bounds.width / 2.0 - sizeFrame / 2.0
            let height = UIScreen.main.bounds.height / 2.0 - sizeFrame / 2.0
            
            let centerXConstraint = NSLayoutConstraint(item: self,
                                                       attribute: .centerX,
                                                       relatedBy: .equal,
                                                       toItem: superview,
                                                       attribute: .centerX,
                                                       multiplier: 1,
                                                       constant: 0.0)
            
            let centerYConstraint = NSLayoutConstraint(item: self,
                                                       attribute: .centerY,
                                                       relatedBy: .equal,
                                                       toItem: superview,
                                                       attribute: .centerY,
                                                       multiplier: 1,
                                                       constant: 0.0)
            
            let widthConstraint = NSLayoutConstraint(item: self,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1,
                                                     constant: width)
            
            let heightXConstraint = NSLayoutConstraint(item: self,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: height)
            
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([centerXConstraint, centerYConstraint, widthConstraint, heightXConstraint])
            
        }
        layoutIfNeeded()
        superview?.layoutIfNeeded()
    }
    
    /// Load view add to subview
    func loadView() {
        if let windowView = UIApplication.shared.keyWindow {
            windowView.addSubview(self)
        }
    }
    
    /// Bring to front
    func bringToFront() {
        superview?.bringSubviewToFront(self)
    }
    
    /// Show loader with animation
    func showView() {
        
        bringToFront()
        configureView()
        
        alpha = 0.0
        isHidden = false
        isShowLoader = true
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIView.AnimationOptions(), animations: { () -> Void in
            self.alpha = 1.0
        }, completion: nil)
    }
    
    /// Hide loader with animation
    func hideView() {
        
        isShowLoader = false
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alpha = 0.0
        }, completion: { (Bool) -> Void in
            if self.isShowLoader == false {
                self.isHidden = true
            }
        })
    }
}

