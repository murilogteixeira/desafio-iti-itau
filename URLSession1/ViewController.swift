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
        DataApp.atualizarDadosDoUsuario(nome: DataApp.dadosDoUsuario["name"] as! String) { success in
            DispatchQueue.main.async {
                if let username = DataApp.dadosDoUsuario["name"] {
                    let user = DataApp.dadosDoUsuario
                    self.labelNome.text = "Olá \(username)!\nAqui está o resumo da sua conta:"
                    if let conta = user["account"] as? [String:Any],
                        let saldoConta = conta["balance"] as? Double,
                        let poupanca = user["savings"] as? [String:Any],
                        let saldoPoupanca = poupanca["balance"] as? Double {
                        
                        self.labelSaldoConta.text = String("R$\(saldoConta)")
                        self.labelSaldoPoupanca.text = String("R$\(saldoPoupanca)")
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func irParaTransferencia(_ sender: Any) {
        
    }
    
    @IBAction func irParaExtrato(_ sender: Any) {
        if let extrato = DataApp.dadosDoUsuario["accountHistoric"] as? [[String:Any]] {
            dadosParaTableView = [
                "comando"   : "extrato",
                "dados"     : extrato
            ]
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

