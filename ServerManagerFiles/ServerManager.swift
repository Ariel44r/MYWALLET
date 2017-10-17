//
//  ServerManager.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 15/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class ServerManager {
    
    let processingQueue = OperationQueue()
    
    func postRequest(_ parametersDict: [String: Any], _ stringURL: String, _ completion: @escaping (_ results: NSDictionary?, _ error: Error?) -> Void) {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            "postman-token": "bc15409e-1c7e-be62-4d31-5f834bc5c976"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: stringURL)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = dataWithJSONObject(parametersDict)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
            if error != nil {
                debugPrint(error ?? "received error from server")
            } else {
                let httpResponse = response as! HTTPURLResponse
                debugPrint("server Response: \(httpResponse)")
            }
            let parsedJSON = self.jsonObjectWithData(data!)
            OperationQueue.main.addOperation({
                completion(parsedJSON, nil)
            })
        })
        dataTask.resume()
    }
    
    //MARK: dataWithJSONObject
    func dataWithJSONObject(_ parametersDict: [String: Any]) -> Data {
        var postData: Data?
        do {
            postData = try JSONSerialization.data(withJSONObject: parametersDict, options: [])
        } catch {
            debugPrint(error)
        }
        return postData!
    }
    
    ///MARK: jsonObjectWithData
    func jsonObjectWithData(_ data: Data) -> NSDictionary {
        var parsedJSON: NSDictionary = [:]
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            parsedJSON = json as! NSDictionary
        } catch {
            debugPrint(error)
        }
        return parsedJSON
    }
    
}
