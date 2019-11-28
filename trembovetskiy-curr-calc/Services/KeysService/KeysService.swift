//
//  KeysService.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import Foundation


/// Keys Service for switch live/dev/test in 'info.plist'. Change 'Key_type' to 'live' or 'dev', or other
class KeysService: NSObject {
    // MARK: - SINGLETON
    static let shared: KeysService = {
        let instance = KeysService()
        return instance
    }()
    
    /// Init key
    ///
    /// - returns: object KeysService
    override init() {
        super.init()
        directory = getDirectory() ?? NSMutableDictionary()
    }
    
    /// Type for key
    let keyType = NSDictionary(dictionary: Bundle.main.infoDictionary!).object(forKey: "Key_type") as? String
    
    /// Directory
    fileprivate var directory: NSMutableDictionary = NSMutableDictionary()
    
    /// Return path to plist
    ///
    /// - returns: path
    fileprivate func getPath() -> String {
        let nameFile = "Key-" + (keyType ?? "")
        return (Bundle.main.path(forResource: nameFile, ofType: "plist") as String?)!
    }
    
    /// Return directory
    ///
    /// - returns: directory
    fileprivate func getDirectory() -> NSMutableDictionary? {
        return NSMutableDictionary(contentsOfFile: getPath())
    }
    
    /// Return string value for key
    ///
    /// - parameter key: key for get string value
    ///
    /// - returns: value
    func string(key: String) -> String? {
        return directory.object(forKey: "\(key)") as? String
    }
}
