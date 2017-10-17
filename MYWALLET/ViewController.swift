//
//  ViewController.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 15/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: variablesAndInstances
    let serverManager = ServerManager()
    let titleHeader1 = "Para vincular la aplicacion a tu cuenta por favor introduce tu número telefónico"
    let messageBody1 = "Teléfono"
    let messageButton1 = "INGRESAR"
    
    //outletsAndActions
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBAction func loginButton(_ sender: Any) {
        displayFieldTextAlert(titleHeader1, messageBody1, messageButton1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func callLoginService(_ phone: String) {
        //["Telefono": "2221474158"]
        let loginParametersDict = ["Telefono": phone]
        let stringURL = "http://209.222.19.75/wsAutorizador/api/autorizador/AUTORIZADOR_ValidaUsuario/"
        serverManager.postRequest(loginParametersDict, stringURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: Alerts
extension ViewController {
    //displaySimpleAlert
    func displaySimpleAlert(_ titleHeader: String, _ messageBody: String, _ messageButton: String) {
        let myalert = UIAlertController(title: titleHeader, message: messageBody, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: messageButton, style: UIAlertActionStyle.default, handler:nil)
        myalert.addAction(okAction)
        self.present(myalert, animated:true, completion:nil)
    }
    
    //DisplayAlertFieldTextInput
    func displayFieldTextAlert (_ titleHeader: String, _ messageBody: String, _ messageButton: String) {
        //Create the alert controller.
        let alert = UIAlertController(title: titleHeader, message: messageBody, preferredStyle: .alert)
        //Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        //Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: messageButton, style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            // Force unwrapping because we know it exists.
            var textFieldUnwrapped = String()
            //checkIfTextFieldIsEmpty
            if textField!.text != nil && textField!.text! != "" {
                textFieldUnwrapped = textField!.text!
                print("Text field: \(textFieldUnwrapped)")
                //CallTheService
                if messageButton == "INGRESAR" {
                    self.callLoginService(textFieldUnwrapped)
                }
            } else if textField!.text! == "" {
                self.displaySimpleAlert("Aviso", "Aun no ha ingresado el número, por favor intente otra vez", "Ok")
            }
        }))
        //Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
}

