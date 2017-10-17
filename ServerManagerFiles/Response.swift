//
//  Response.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 17/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class Response {
    var codigoRespuesta: String
    var descripcion: String
    var ID_usuario: String
    var tokenSeguridad: String
    
    init(_ codigoRespuesta: String, _ descripcion: String, _ ID_usuario: String, _ tokenSeguridad: String) {
        self.codigoRespuesta = codigoRespuesta
        self.descripcion = descripcion
        self.ID_usuario = ID_usuario
        self.tokenSeguridad = tokenSeguridad
    }
}
