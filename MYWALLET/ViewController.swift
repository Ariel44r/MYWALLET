//
//  ViewController.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 15/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let serverMAnager = ServerManager()
    let loginParametersDict = ["Telefono": "2221474158"]
    let stringURL = "http://209.222.19.75/wsAutorizador/api/autorizador/AUTORIZADOR_ValidaUsuario/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        serverMAnager.loginRequest(loginParametersDict, stringURL)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

