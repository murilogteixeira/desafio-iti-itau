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
        let conta = DataApp.dadosDoUsuario["account"] as! [String:Any]
        saldoLabel.text = "Saldo R$ \(conta["balance"] as! Double)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func alterarConta(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            let conta = DataApp.dadosDoUsuario["account"] as! [String:Any]
            saldoLabel.text = "Saldo R$ \(conta["balance"] as! Double)"
        } else if segmentedControl.selectedSegmentIndex == 1 {
            let poupanca = DataApp.dadosDoUsuario["savings"] as! [String:Any]
            saldoLabel.text = "Saldo R$ \(poupanca["balance"] as! Double)"
        }
    }
}
