//
//  RestBase+Cancel.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import Foundation
import Alamofire

extension RestBase {
    
    /// Cancel request by identifier
    ///
    /// - parameter identifier: name of request
    static func cancelRequests(by identifier : String) {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach {
                if $0.taskDescription == identifier {
                    $0.cancel()
                }
            }
            uploadTasks.forEach {
                if $0.taskDescription == identifier {
                    $0.cancel()
                }
            }
            downloadTasks.forEach {
                if $0.taskDescription == identifier {
                    $0.cancel()
                }
            }
        }
    }
    
    /// Is request in running (ignore background request)
    ///
    /// - parameter completion: result is request in running now (ignore background request)
    static func isRequestInRunning(_ completion: @escaping (_ isRequest: Bool) -> Void) {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            
            var isRequest = false
            
            for task in dataTasks {
                if task.state == .running {
                    if task.taskDescription != RestAPIBackground {
                        isRequest = true
                    }
                }
            }
            for task in uploadTasks {
                if task.state == .running {
                    if task.taskDescription != RestAPIBackground {
                        isRequest = true
                    }
                }
            }
            for task in downloadTasks {
                if task.state == .running {
                    if task.taskDescription != RestAPIBackground {
                        isRequest = true
                    }
                }
            }
            completion(isRequest)
        }
    }
}

