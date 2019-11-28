//
//  RestBase+Model.swift
//  trembovetskiy-curr-calc
//
//  Created by Kiril Trembovetskiy on 17.11.2019.
//

import Foundation
import Alamofire
import Toaster
import SwiftyJSON

extension RestBase {
    
    func call <Model>(
        model type: Model.Type,
        method: RestMethod,
        path: String,
        loader: Bool,
        sender: String?,
        callback: @escaping (Result<Model?, ErrorModel?>) -> Void) where Model: Decodable {
        
        beforeCall(with: loader)
    
        let request = Alamofire.request(path,
                                        method: RestMethod.toAlamofile(method),
                                        parameters: nil,
                                        encoding: URLEncoding.default,
                                        headers: nil).responseJSON { (response) in
                                            self.afterCall()
                                            switch response.result {
                                            case .success(let model):
                                                if let statusCode = response.response?.statusCode {
                                                    if statusCode >= 200 && statusCode <= 299 {
                                                        
                                                        if ((model as? RestAPIModel)?.ok ?? "") == RestAPIModelStaus.ok || ((model as? RestAPIModel)?.ok ?? "") == RestAPIModelStaus.error {
                                                            
                                                            guard let data = response.data, let error = try? JSONDecoder().decode(ErrorModel.self, from: data)  else {
                                                                debugPrint("Error data parsing")
                                                                callback(.failed(nil))
                                                                return
                                                            }
                                                            callback(.failed(error))
                                                            return
                                                        }
                                                        
                                                        let data = JSON(response.result.value ?? [])
                                                        if let jsonData = try? data.rawData() {
                                                            if let responseObject = try? JSONDecoder().decode(Model.self, from: jsonData) {
                                                                callback(.success(responseObject))
                                                                return
                                                            }
                                                        }
                                                        debugPrint("Error data parsing")
                                                        callback(.failed(nil))
                                                        return
                                                        
                                                    } else {
                                                        guard let data = response.data, let error = try? JSONDecoder().decode(ErrorModel.self, from: data)  else {
                                                            debugPrint("Error data parsing")
                                                            callback(.failed(nil))
                                                            return
                                                        }
                                                        callback(.failed(error))
                                                        return
                                                    }
                                                }
                                            case .failure(_):
                                                print("")
                                            }
                                            
            }.responseData { (response) in
                print("-----------!!!!!!!--------")
                print(response.result.value)
                print("-----------!!!!!!!--------")
                debugPrint("=====================REQUEST=============================")
                debugPrint("send to server:", response.request?.httpMethod ?? "<http method is empty>", response.request?.url?.absoluteString ?? "<url is nil>")
                debugPrint("headers:", response.request?.allHTTPHeaderFields ?? "<headers is empty>")
                debugPrint("response: \(String(describing: String(data: response.data!, encoding: String.Encoding.utf8) ?? ("-")))")
                debugPrint("==========================================================")
        }
        request.task?.taskDescription = sender
    }
}
