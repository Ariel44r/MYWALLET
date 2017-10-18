//
//  MovementTableViewCell.swift
//  MYWALLET
//
//  Created by Ariel Ramírez on 18/10/17.
//  Copyright © 2017 Ariel Ramírez. All rights reserved.
//

import UIKit

class MovementTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var labelFecha: UILabel!
    @IBOutlet weak var labelTarjeta: UILabel!
    @IBOutlet weak var labelMonto: UILabel!
    @IBOutlet weak var labelFechaServer: UIView!
    @IBOutlet weak var labelTarjetaServer: UILabel!
    @IBOutlet weak var labelImporteServer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
