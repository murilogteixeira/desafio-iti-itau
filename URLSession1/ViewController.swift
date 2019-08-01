//
//  ViewController.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 23/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelSaldoConta: UILabel!
    @IBOutlet weak var labelSaldoPoupanca: UILabel!
    
    var dadosParaTableView = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataApp.atualizarDadosDoUsuario(nome: DataApp.usuario.name) { success in
            DispatchQueue.main.async {
                self.labelNome.text = "Olá \(DataApp.usuario.name)!\nAqui está o resumo da sua conta:"
                    
                self.labelSaldoConta.text = String("\(DataApp.usuario.account.balance)".doubleValue.currency)
                self.labelSaldoPoupanca.text = String("\(DataApp.usuario.savings.balance)".doubleValue.currency)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func irParaTransferencia(_ sender: Any) {
        
    }
    
    @IBAction func irParaExtrato(_ sender: Any) {
        dadosParaTableView = [
            "comando"   : "extrato",
            "dados"     : DataApp.usuario.account.historic
        ]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

