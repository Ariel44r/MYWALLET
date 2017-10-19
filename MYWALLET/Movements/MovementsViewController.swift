//
//  MovementsViewController.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 18/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

class MovementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: variablesAndInstances
    var response: Response?
    let reuseIdentifier = "movementsCell"
    let processMovements = ProcessMovements()
    var movements = [Movements]()
    var responseMovements: ResponseMovements?
    
    //MARK: Outlets
    @IBOutlet weak var movementsTableView: UITableView!
    @IBOutlet weak var labelMyWallet: UILabel!
    @IBOutlet weak var labelSaldoServer: UILabel!
    @IBOutlet weak var labelSaldo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.response!.printResponse()
        processMovements.callMovementsService(self.response!.tokenSeguridad) {
            results, resultsArray, error in
            if let error = error {
                debugPrint(error)
            }
            if let results = results {
                //receivedResponseMovementsObject
                self.responseMovements = results
                self.labelSaldo.text = results.saldo
                debugPrint("SALDO: \(results.saldo)")
            }
            if let resultsArray = resultsArray {
                //receivedMovementsArray
                self.movements = resultsArray
                self.movementsTableView.reloadData()
                debugPrint("Tarjeta: \(resultsArray[0].tarjeta)")
            }
        }
        // Do any additional setup after loading the view.
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

//MARK: Delegates
extension MovementsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MovementTableViewCell
        cell.labelFechaServer.text = movements[indexPath.row].fecha
        cell.labelImporteServer.text = movements[indexPath.row].importe
        cell.labelTarjetaServer.text = movements[indexPath.row].tarjeta
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue for Detail
    }
}
