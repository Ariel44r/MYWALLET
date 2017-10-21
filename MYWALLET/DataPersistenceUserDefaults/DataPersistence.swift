//
//  DataPersistence.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 21/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import Foundation

class DataPersistence {
    
    static func checkIfUserIsLoged() -> (isLoged: Bool, response: Response) {
        let response = Response("","","","")
        if UserDefaults.standard.object(forKey: "isLoged") != nil {
            let codigoRespuesta = UserDefaults.standard.object(forKey: "codigoRespuesta") as! String
            let descripcion = UserDefaults.standard.object(forKey: "descripcion") as! String
            let ID_usuario = UserDefaults.standard.object(forKey: "ID_usuario") as! String
            let tokenSeguridad = UserDefaults.standard.object(forKey: "tokenSeguridad") as! String
            let response = Response(codigoRespuesta,descripcion,ID_usuario,tokenSeguridad)
            return(true, response)
        }
        return (false, response)
    }
    
    static func saveUserPreferences(_ response: Response) {
        UserDefaults.standard.set(1, forKey: "isLoged")
        UserDefaults.standard.set(response.codigoRespuesta,forKey: "codigoRespuesta")
        UserDefaults.standard.set(response.descripcion,forKey: "descripcion")
        UserDefaults.standard.set(response.ID_usuario,forKey: "ID_usuario")
        UserDefaults.standard.set(response.tokenSeguridad,forKey: "tokenSeguridad")
    }
    
    static func removeUserPreferences () {
        UserDefaults.standard.removeObject(forKey: "isLoged")
        UserDefaults.standard.removeObject(forKey: "codigoRespuesta")
        UserDefaults.standard.removeObject(forKey: "descripcion")
        UserDefaults.standard.removeObject(forKey: "ID_usuario")
        UserDefaults.standard.removeObject(forKey: "tokenSeguridad")
    }
}
