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
    let titleHeader1 = Constants.textAlertParam.HEADER1
    let messageBody1 = Constants.textAlertParam.MESSAGEBODDY1
    let messageButton1 = Constants.textAlertParam.MESSAGEBUTTON1
    var dataFromServer: NSDictionary = [:]
    var response: Response?
    
    //mark: outletsAndActions
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBAction func loginButton(_ sender: Any) {
        headerLabel.text = "Login"
        displayFieldTextAlert(titleHeader1, messageBody1, messageButton1) {
            results, error in
            if let error = error {
                debugPrint("Error: \(error)")
            }
            if let results = results {
                self.callLoginService(results)
            }
        }
    }
    
    func callLoginService(_ phone: String) {
        serverManager.postRequest("LOGIN","Telefono",phone) {
            results, error in
            if let error = error {
                debugPrint("Error: \(error)")
                return
            }
            if let results = results {
                self.dataFromServer = results
                if self.validateResponseCode(self.dataFromServer) {
                    self.callSMSValidationService(phone, Constants.textAlertParam.TEXTALERTPARAM2)
                }
            }
        }
    }
    
    func callSMSValidationService(_ phone: String, _ textAletrParameters: [String: String]) {
        headerLabel.text = "Validación SMS"
        var codigoValidacionInput: String?
        displayFieldTextAlert(textAletrParameters["titleHeader"]!, textAletrParameters["messageBody"]!, textAletrParameters["messageButton"]!) {
            results, error in
            if let error = error {
                debugPrint("Error: \(error)")
            }
            if let results = results {
                debugPrint(results)
                codigoValidacionInput = results
                self.serverManager.postRequest("SMS","Telefono",phone) {
                    results, error in
                    if let error = error {
                        debugPrint("Error from server: \(error)")
                        return
                    }
                    if let results = results {
                        //after receive data from server
                        if self.validateResponseCode(results) {
                            let response = self.parseResponse(results)
                            //response.printResponse()
                            self.response = response
                            let codigoValidacion = "123456"
                                if codigoValidacion == codigoValidacionInput {
                                    //callFunctionToDownloadMovements
                                    debugPrint("DEPLOY MOVEMENTS")
                                    self.performSegue(withIdentifier: "movementsSegue", sender: nil)
                                }
                                else {
                                    self.recallSMSValidation(phone)
                                }
                        }
                    }
                }
            }
        }
    }
    
    func recallSMSValidation(_ telefono: String) {
        self.callSMSValidationService(telefono, Constants.textAlertParam.TEXTALERTPARAMETERSINCORRECT)
    }
    
    //validateResponseCode
    func validateResponseCode(_ dataFromServer: NSDictionary) -> Bool {
        if let _ = dataFromServer["CodigoRespuesta"] as? String {
            return true
        }
        return false
    }
    
    //parseResponse
    func parseResponse(_ results: NSDictionary) -> Response {
        let codigoRespuesta: String = results["CodigoRespuesta"] as! String
        let descripcion: String = results["Descripcion"] as! String
        let ID_usuario: String = results["ID_Usuario"] as! String
        let tokenSeguridad: String =  results["TokenSeguridad"] as! String
        let response = Response(codigoRespuesta,descripcion,ID_usuario,tokenSeguridad)
        return response
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movementsSegue" {
            let movementsVC = segue.destination as! MovementsViewController
            movementsVC.response = self.response!
        }
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
    func displayFieldTextAlert (_ titleHeader: String, _ messageBody: String, _ messageButton: String,_ completion: @escaping (_ results: String?, _ error: Error?) -> Void) {
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
                //return the textFieldUnwrapped value
                OperationQueue.main.addOperation({
                    completion(textFieldUnwrapped, nil)
                })
            } else if textField!.text! == "" {
                self.displaySimpleAlert(Constants.textAlertParam.SIMPLEALERTH,Constants.textAlertParam.SIMPLEALERTB, Constants.textAlertParam.SIMPLEALERTBUT)
            }
        }))
        //Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    //displaySimpleAlertWithIndicator
    func displaySimpleAlertWithIndicator(_ titleHeader: String, _ messageBody: String, _ messageButton: String) -> Bool {
        let myalert = UIAlertController(title: titleHeader, message: messageBody, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: messageButton, style: UIAlertActionStyle.default, handler:nil)
        myalert.addAction(okAction)
        self.present(myalert, animated:true, completion:nil)
        return true
    }
}

