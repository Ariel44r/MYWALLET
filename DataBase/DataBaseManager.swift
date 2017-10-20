//
//  DataBaseManager.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 20/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
///Users/aramirez/Desktop/iOS/MYWALLET/DataBase/DataBaseManager.swift

import Foundation
import SQLite3

class DataBaseManager {
    
    func getPath() -> String {
        let dbURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let dbPath = dbURL.appendingPathComponent("Movements.db")
        debugPrint("DATABASE PATH: \(dbPath.path)")
        return dbPath.path
    }
    
    func connectToDB() -> OpaquePointer {
        
        let dbPath = getPath()
        var db: OpaquePointer?
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("error opening database")
        } else {
            if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Movements(Tarjeta VARCHAR(20) NOT NULL, Fecha varchar(25) NOT NULL, Sucursal VARCHAR(20) NOT NULL, Afiliacion VARCHAR(20) NOT NULL, Terminal VARCHAR(20) NOT NULL, Operador VARCHAR(20) NOT NULL, Autorizacion VARCHAR(20) NOT NULL, Importe VARCHAR(20) NOT NULL, Ticket VARCHAR(20) NOT NULL, ID_Operacion VARCHAR(20) NOT NULL);", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error creating table: \(errmsg)")
            }
        }
        return db!
    }
    
}
