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
    
    func postRequest(_ service: String,_ varToUpdate: String,_ valToUpdate: String, _ completion: @escaping (_ results: NSDictionary?, _ error: Error?) -> Void) {
        let headers = [
            "Content-Type": "application/json"
        ]
        let parametersAndURL = getParametersAndURL(service, varToUpdate, valToUpdate)
        let request = NSMutableURLRequest(url: NSURL(string: parametersAndURL.URL)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: Constants.Servers.timeOut)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = dataWithJSONObject(parametersAndURL.parameters)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
            if error != nil {
                debugPrint(error ?? "received error from server")
            } else {
                let httpResponse = response as! HTTPURLResponse
                debugPrint("server Response: \(httpResponse)")
            }
            if let dataReceived = data {
                let parsedJSON = self.jsonObjectWithData(dataReceived)
                OperationQueue.main.addOperation({
                    completion(parsedJSON, nil)
                })
            }
        })
        dataTask.resume()
    }
    
    func postRequestAutorize(_ completion: @escaping (_ results: NSDictionary?, _ error: Error?) -> Void) {
        let headers = [
            "Content-Type": "application/json"
        ]
        let URL = Constants.Servers.URL_SERVER + Constants.Servers.endAutorizacion
        let parameters = [
            "EsAutorizado":true,
            "ID_Operacion":"123"
            ] as [String : Any]
        let request = NSMutableURLRequest(url: NSURL(string: URL)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = dataWithJSONObject(parameters)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
            if error != nil {
                debugPrint(error ?? "received error from server")
                //Constants.progressIndicator.progressText("You are not connected to internet", "Please check the connection and try again")
            } else {
                let httpResponse = response as! HTTPURLResponse
                debugPrint("server Response: \(httpResponse)")
            }
            if let dataReceived = data {
                let parsedJSON = self.jsonObjectWithData(dataReceived)
                OperationQueue.main.addOperation({
                    completion(parsedJSON, nil)
                })
            }
        })
        dataTask.resume()
        
    }
    
    func getParametersAndURL(_ service: String, _ varToUpdate: String, _ valueToUpdate: String) -> (parameters: [String: String], URL: String) {
        var parameters = Constants.ServerParameters.PARAMETERS[service]!
        parameters[varToUpdate] = valueToUpdate
        let  URL: String = Constants.Servers.URL_SERVER + Constants.Servers.ENDS[service]!
        return (parameters, URL)
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
