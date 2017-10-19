//
//  Movements.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 18/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class Movements {
    
    var tarjeta: String
    var fecha: String
    var sucursal: String
    var afiliacion: String
    var terminal: String
    var operador: String
    var autorizacion: String
    var importe: String
    var ticket: String
    var ID_operacion: String
    
    init(_ tarjeta: String,_ fecha: String,_ sucursal: String,_ afiliacion: String,_ terminal: String,_ operador: String,_ autorizacion: String,_ importe: String,_ ticket: String,_ ID_operacion: String) {
        self.tarjeta = tarjeta
        self.fecha = fecha
        self.sucursal = sucursal
        self.afiliacion = afiliacion
        self.terminal = terminal
        self.operador = operador
        self.autorizacion = autorizacion
        self.importe = importe
        self.ticket = ticket
        self.ID_operacion = ID_operacion
    }
    
    func printMovement() {
        debugPrint(tarjeta)
        debugPrint(fecha)
        debugPrint(sucursal)
        debugPrint(afiliacion)
        debugPrint(terminal)
        debugPrint(operador)
        debugPrint(autorizacion)
        debugPrint(importe)
        debugPrint(ticket)
        debugPrint(ID_operacion)        
    }
}
