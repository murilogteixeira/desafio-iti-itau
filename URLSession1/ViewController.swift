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

    var lista = [[String:Any]]()
    
    var alfabeto = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var contatos = ["A":[""], "B":[""], "C":[""], "D":[""], "E":[""], "F":[""], "G":[""], "H":[""], "I":[""], "J":[""], "K":[""], "L":[""], "M":[""], "N":[""], "O":[""], "P":[""], "Q":[""], "R":[""], "S":[""], "T":[""], "U":[""], "V":[""], "W":[""], "X":[""], "Y":[""], "Z":[""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        View.loadingView(show: true, showLoading: true, view: self.view)
        DataApp.atualizarDadosDoUsuario(nome: DataApp.dadosDoUsuario["name"] as! String) { success in
            print(success)
            View.loadingView(show: false, view: self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let username = DataApp.dadosDoUsuario["name"] {
            let user = DataApp.dadosDoUsuario
            labelNome.text = "Olá \(username)!\nAqui está o resumo da sua conta:"
            if let saldoConta = user["accountBalance"] as? Double,
                let saldoPoupanca = user["savingsBalance"] as? Double {
                labelSaldoConta.text = String("R$\(saldoConta)")
                labelSaldoPoupanca.text = String("R$\(saldoPoupanca)")
            }
        }
    }
    
    @IBAction func irParaTransferencia(_ sender: Any) {
    }
    
    @IBAction func irParaExtrato(_ sender: Any) {
        if let extrato = DataApp.dadosDoUsuario["accountHistoric"] as? [String:Any] {
            dadosParaTableView = [
                "comando"   : "extrato",
                "dados"     : extrato
            ]
            performSegue(withIdentifier: "vaiTableView", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TableViewController {
            vc.dadosTableView = dadosParaTableView
        }
    }
    
}

