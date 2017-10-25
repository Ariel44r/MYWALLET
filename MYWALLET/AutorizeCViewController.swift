//
//  AutorizeCViewController.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 24/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

class AutorizeCViewController: UIViewController {

    var received: [String:Any] = [String:Any]()
    let serverManager = ServerManager()
    var dataFromServer: [String: Any]?
    var response: Response?
    
    @IBOutlet weak var fieldText: UITextView!
    @IBAction func rechazarButton(_ sender: Any) {
        displaySimpleAlert("La compra no fue autorizada", "", "Ok")
    }
    @IBAction func autorizarButton(_ sender: Any) {
        callAutorizeService()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let tarjeta = received["tarjeta"] {
            if let monto = received["monto"] {
                fieldText.text = "Se intenta realizar una compra con tu tarjeta terminacion: ************\(tarjeta) en Armit por un monto de $ \(monto) ¿Deseas autorizar la compra?"
            }
        }
    }

    func callAutorizeService() {
        serverManager.postRequestAutorize() {
            results, error in
            if let error = error {
                debugPrint("Error: \(error)")
                return
            }
            if let results = results {
                self.dataFromServer = results as? [String: Any]
                self.displaySimpleAlert(self.dataFromServer!["Descripcion"] as! String, "", "Ok")
            }
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //displaySimpleAlert
    func displaySimpleAlert(_ titleHeader: String, _ messageBody: String, _ messageButton: String) {
        let myalert = UIAlertController(title: titleHeader, message: messageBody, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: messageButton, style: UIAlertActionStyle.default, handler:nil)
        myalert.addAction(okAction)
        self.present(myalert, animated:true, completion:nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
