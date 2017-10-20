//
//  DataBaseManager.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 20/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

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
            print("has successfully entered into Movements database dude!")
            if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Movements(name VARCHAR(60) NOT NULL, lastName varchar(60) NOT NULL, cellPhone VARCHAR(16) NOT NULL, ID VARCHAR(5) NOT NULL, imagePath VARCHAR(200) NOT NULL);", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error creating table: \(errmsg)")
            }
        }
        return db!
    }
    
}
