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
    
    let messageHeader1 = "Para vincular la aplicacion a tu cuenta por favor introduce tu número telefónico"
    
    @IBAction func loginButton(_ sender: Any) {
        displayFieldTextAlert(messageHeader1)
        serverMAnager.loginRequest(loginParametersDict, stringURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: Alerts
    //displaySimpleAlert
    func displaySimpleAlert(userMessage:String) {
        let myalert = UIAlertController(title:"Aviso", message:userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:"ok", style: UIAlertActionStyle.default, handler:nil)
        myalert.addAction(okAction)
        self.present(myalert, animated:true, completion:nil)
    }
    
    //DisplayAlertFieldTextInput
    func displayFieldTextAlert (_ messageHeader: String) {
        //Create the alert controller.
        let alert = UIAlertController(title: messageHeader, message: "", preferredStyle: .alert)
        //Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        //Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "INGRESAR", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            var textFieldUnwrapped = String()
            //checkIfTextFieldIsEmpty
            if textField!.text != nil && textField!.text! != "" {
                textFieldUnwrapped = textField!.text!
                print("Text field: \(textFieldUnwrapped)")
            } else if textField!.text! == "" {
                self.displaySimpleAlert(userMessage: "Aun no ha ingresado el número, por favor intente otra vez")
            }
        }))
        //Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

