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
    
    let api = API()
    let userDefaults = UserDefaults.standard
    let dadosUserDefaults = "dadosUserDefaults"

    var lista = [[String:Any]]()
    
    var alfabeto = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var contatos = ["A":[""], "B":[""], "C":[""], "D":[""], "E":[""], "F":[""], "G":[""], "H":[""], "I":[""], "J":[""], "K":[""], "L":[""], "M":[""], "N":[""], "O":[""], "P":[""], "Q":[""], "R":[""], "S":[""], "T":[""], "U":[""], "V":[""], "W":[""], "X":[""], "Y":[""], "Z":[""]]
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = self.userDefaults.dictionary(forKey: self.dadosUserDefaults) {
            labelNome.text = "Olá \(user["name"] as! String)!\nAqui está o resumo da sua conta:"
            if let saldoConta = user["accountBalance"] as? Double,
                let saldoPoupanca = user["savingsBalance"] as? Double {
                labelSaldoConta.text = String("R$\(saldoConta)")
                labelSaldoPoupanca.text = String("R$\(saldoPoupanca)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
//        for letra in alfabeto {
//            print("\(letra): \(contatos[letra]!)")
//        }
//
//        print(alfabeto)
    }
    
}

