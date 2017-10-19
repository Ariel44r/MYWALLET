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
    
    func callMovementsService(_ tokenSeguridad: String, _ completion: @escaping (_ results: ResponseMovements?,_ resultsArray: [Movements]?, _ error: Error?) -> Void) {
        let movementsParameterDict = ["TokenSeguridad":tokenSeguridad]
        let stringURL = "http://209.222.19.75/wsAutorizador/api/autorizador/AUTORIZADOR_GetSaldosMovimientos"
        serverManager.postRequest(movementsParameterDict, stringURL) {
            results, error in
            if let error = error {
                debugPrint("Error: \(error)")
                return
            }
            if let results = results {
                let responseObjects = self.parseResponse(results)
                OperationQueue.main.addOperation({
                    completion(responseObjects.responseMovement,responseObjects.movements, nil)
                })                //debugPrint(results)
                //parseResultsAndReceiveMovementsObject
                //self.parseResponse(results)
            }
        }
    }
    
    //parseResponse
    func parseResponse(_ results: NSDictionary) -> (responseMovement: ResponseMovements,movements: [Movements]) {
        let codigoRespuesta: Int = results["CodigoRespuesta"] as! Int
        let descripcion: String = results["Descripcion"] as! String
        let saldo: String = results["Saldo"] as! String
        let responseMovements = ResponseMovements(codigoRespuesta,descripcion,saldo)
        debugPrint("codigo: \(codigoRespuesta), descripcion: \(descripcion), saldo: \(saldo)")
        let operaciones: NSArray = results["OPERACIONES"] as! NSArray
        var movements = [Movements]()
        
        /*let operacion1: NSDictionary = operaciones[0] as! NSDictionary
        let tarjeta: String = operacion1["Fecha"] as! String
        debugPrint(tarjeta)*/
        
        for index in 0 ..< operaciones.count {
            let operacion: NSDictionary = operaciones[index] as! NSDictionary
            let tarjeta: String = operacion["Tarjeta"] as! String
            let fecha: String = operacion["Fecha"] as! String
            let sucursal: String = operacion["Sucursal"] as! String
            let afiliacion: String = operacion["Afiliacion"] as! String
            let terminal: String = operacion["Terminal"] as! String
            let operador: String = operacion["Operador"] as! String
            let autorizacion: String = operacion["Autorizacion"] as! String
            let importe: String = operacion["Importe"] as! String
            let ticket: String = operacion["Ticket"] as! String
            let ID_operacion: String = operacion["ID_Operacion"] as! String
            let movement = Movements(tarjeta,fecha,sucursal,afiliacion,terminal,operador,autorizacion,importe,ticket,ID_operacion)
            movements.append(movement)
        }
        return(responseMovements,movements)
    }
    
}
