//
//  ReachabilityService.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import UIKit
import Alamofire

public enum ReachabilityError: Error {
    case notReachable
}

public enum ReachabilityStatus {
    case unknown
    case notReachable
    case reachable
}

public struct ReachabilityService {
    
    // MARK: -
    // MARK: SINGLETON
    static let shared: ReachabilityService = {
        let instance = ReachabilityService()
        return instance
    }()
    
    /// Alamofire (NetworkReachabilityManager)
    private let networkManager = NetworkReachabilityManager()!
    
    /// key to send notification by changing the status of the network
    public let reachabilityStatusChanged = NSNotification.Name(rawValue:"NSNotificationKeyReachabilityStatusChanged")
    
    //MARK:-
    //MARK: check network
    
    /// checking internet connection
    ///
    /// - returns: network status
    public func isConnection() -> Bool {
        switch networkManager.networkReachabilityStatus {
        case NetworkReachabilityManager.NetworkReachabilityStatus.notReachable, NetworkReachabilityManager.NetworkReachabilityStatus.unknown:
            return false
        default:
            return true
        }
    }
    
    /// checking internet connection (throws)
    ///
    /// - throws: in the absence of network
    public func checkingConnection() throws {
        switch networkManager.networkReachabilityStatus {
        case NetworkReachabilityManager.NetworkReachabilityStatus.notReachable,
             NetworkReachabilityManager.NetworkReachabilityStatus.unknown:
            throw ReachabilityError.notReachable
        default: return
        }
    }
    
    //MARK:-
    //MARK: listening
    
    /// start
    ///
    public func startListening() {
        networkManager.listener = { status in
            
            let reachabilityStatus: ReachabilityStatus = {
                switch status {
                case NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.ethernetOrWiFi):
                    return ReachabilityStatus.reachable
                case NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.wwan):
                    return ReachabilityStatus.reachable
                case NetworkReachabilityManager.NetworkReachabilityStatus.notReachable:
                    return ReachabilityStatus.notReachable
                default:
                    return ReachabilityStatus.unknown
                }
            } ()
            
            /// - unknown:      It is unknown whether the network is reachable.
            /// - notReachable: The network is not reachable.
            /// - reachable:    The network is reachable.
            
            NotificationCenter.default.post(name: self.reachabilityStatusChanged,
                                            object: nil,
                                            userInfo: ["status": reachabilityStatus])
        }
        
        networkManager.startListening()
    }
    
    /// stop
    ///
    public func stopListening() {
        networkManager.stopListening()
    }
    
}

/*
 - applicationWillTerminate
 - applicationDidEnterBackground
 stopListening()
 
 - applicationDidBecomeActive
 startListening()
 */

