//
//  MovementsViewController.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 18/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

protocol MovementsViewControllerDelegate: class {
    func logOut()
}

class MovementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: variablesAndInstances
    var response: Response?
    let reuseIdentifier = "movementsCell"
    let processMovements = ProcessMovements()
    var movements = [Movements]()
    var responseMovements: ResponseMovements?
    weak var delegate: MovementsViewControllerDelegate?
    
    //MARK: OutletsAndActions
    @IBOutlet weak var movementsTableView: UITableView!
    @IBOutlet weak var labelMyWallet: UILabel!
    @IBOutlet weak var labelSaldoServer: UILabel!
    @IBOutlet weak var labelSaldo: UILabel!
    
    @IBAction func logOutButton(_ sender: Any) {
        self.actionSheetMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMovements()
        // Do any additional setup after loading the view.
    }

    func getMovements() {
        Constants.progressIndicator.progressText("Getting movements", "Please hold on")
        processMovements.callMovementsService(self.response!.tokenSeguridad) {
            results, resultsArray, error in
            if let error = error {
                debugPrint(error)
            }
            if let results = results {
                //receivedResponseMovementsObject
                self.responseMovements = results
                self.labelSaldoServer.text = "$ \(results.saldo)"
            }
            if let resultsArray = resultsArray {
                //receivedMovementsArray
                self.movements = resultsArray
                self.movementsTableView.reloadData()
                Constants.progressIndicator.dismissProgress()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: Delegates
extension MovementsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MovementTableViewCell
        cell.labelFechaServer.text = movements[indexPath.row].fecha
        cell.labelImporteServer.text = "$ \(movements[indexPath.row].importe)"
        cell.labelTarjetaServer.text = maskCardNumbers(movements[indexPath.row].tarjeta)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue for Detail
    }
}

extension MovementsViewController {
    func maskCardNumbers(_ card: String) -> String {
        var maskCard: String = ""
        for _ in 0 ..< (card.count - 4) {
            maskCard.insert("*", at: maskCard.endIndex)
        }
        for index in (card.count - 4) ..< card.count {
            let indexChar = card.index(card.startIndex, offsetBy: index)
            maskCard.insert(card[indexChar], at: maskCard.endIndex)
        }
        return maskCard
    }
}

extension MovementsViewController {
    func actionSheetMenu() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let refreshMovements = UIAlertAction(title: "Refresh Movements", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            debugPrint("Refresh Movements Selected")
            self.getMovements()
        })
        let logOut = UIAlertAction(title: "Log Out", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            debugPrint("Log Out selected")
            self.dismiss(animated: true, completion: nil)
            DataPersistence.removeUserPreferences()
            self.delegate?.logOut()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel Selected")
        })
        optionMenu.addAction(refreshMovements)
        optionMenu.addAction(logOut)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
}
