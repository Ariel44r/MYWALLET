//
//  ResponseMovements.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 18/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class ResponseMovements {
    
    var codigoRespuesta: Int
    var descripcion: String
    var saldo: String
    
    init(_ codigoRespuesta: Int, _ descripcion: String, _ saldo: String) {
        self.codigoRespuesta = codigoRespuesta
        self.descripcion = descripcion
        self.saldo = saldo
    }
}
