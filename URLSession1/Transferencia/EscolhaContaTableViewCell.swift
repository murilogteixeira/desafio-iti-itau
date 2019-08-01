//
//  EscolhaContaTableViewCell.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 29/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit

class EscolhaContaTableViewCell: UITableViewCell {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var saldoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let conta = DataApp.dadosDoUsuario["account"] as! [String:Any]
        saldoLabel.text = "Saldo "+"\(DataApp.usuario.account.balance)".doubleValue.currency
        DataApp.tipoContaTransferencia = segmentedControl.selectedSegmentIndex
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func alterarConta(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            saldoLabel.text = "Saldo "+"\(DataApp.usuario.account.balance)".doubleValue.currency
        } else if segmentedControl.selectedSegmentIndex == 1 {
            saldoLabel.text = "Saldo "+"\(DataApp.usuario.savings.balance)".doubleValue.currency
        }
        DataApp.tipoContaTransferencia = segmentedControl.selectedSegmentIndex
    }
}
