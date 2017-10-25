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
    
    @IBOutlet weak var fieldText: UITextView!
    @IBAction func rechazarButton(_ sender: Any) {
    }
    @IBAction func autorizarButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let tarjeta = received["tarjeta"] {
            if let monto = received["monto"] {
                fieldText.text = "Se intenta realizar una compra con tu tarjeta terminacion ************\(tarjeta) en Armit por un monto de $ \(monto) ¿Deseas autorizar la compra?"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
