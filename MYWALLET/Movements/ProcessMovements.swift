//
//  ProcessMovements.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 18/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class ProcessMovements {
    
    let processingQueue = OperationQueue()
    var movements = [Movements]()
    let serverManager = ServerManager()
    
    func callMovementsService(_ tokenSeguridad: String) {
        let movementsParameterDict = ["TokenSeguridad":tokenSeguridad]
        let stringURL = "http://209.222.19.75/wsAutorizador/api/autorizador/AUTORIZADOR_GetSaldosMovimientos"
        serverManager.postRequest(movementsParameterDict, stringURL) {
            results, error in
            if let error = error {
                debugPrint("Error: \(error)")
                return
            }
            if let results = results {
                //debugPrint(results)
                //parseResultsAndReceiveMovementsObject
                self.parseResponse(results)
            }
        }
    }
    
    //parseResponse
    func parseResponse(_ results: NSDictionary) {
        let codigoRespuesta: Int = results["CodigoRespuesta"] as! Int
        let descripcion: String = results["Descripcion"] as! String
        let saldo: String = results["Saldo"] as! String
        debugPrint("codigo: \(codigoRespuesta), descripcion: \(descripcion), saldo: \(saldo)")
        let operaciones: NSArray = results["OPERACIONES"] as! NSArray
        debugPrint(operaciones)
    }
    
}
