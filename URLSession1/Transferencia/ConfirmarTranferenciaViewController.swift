//
//  ConfirmarTranferenciaTableViewController.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 29/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit

class ConfirmarTranferenciaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var tipoConta = 0
    var tipoContaString = ""
    var saldo = 0.0
    var contato = ""
    var valorTransferencia = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doneButtonAction)))
    }

    @IBAction func confirmarTransferencia(_ sender: Any) {
        guard valorTransferencia != 0 else {
            View.showOkAlert(title: "Erro", message: "Valor mínimo para transferência é de \("1".doubleValue.currency)", viewController: self, completion: {})
            return
        }
        
        if tipoConta == 0 {
            tipoContaString = "account"
        } else if tipoConta == 1 {
            tipoContaString = "savings"
        }
        
        let json: [String : Any] = [
            "from"  : DataApp.usuario.name,
            "to"    : contato,
            "type"  : tipoContaString,
            "value" : valorTransferencia
        ]
        
        View.loadingView(show: true, showLoading: true, view: self.view)
        API.transfer(option: "conta/transfer", json: json) { success, msg in
            View.loadingView(show: false, view: self.view)
            guard success != nil else {
                View.showOkAlert(title: "Erro", message: msg, viewController: self, completion: {})
                return
            }
            View.showOkAlert(title: "Sucesso", message: msg, viewController: self, completion: {
                self.performSegue(withIdentifier: "vaiMinhaConta", sender: self)
            })
            
        }
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "De:"
        } else if section == 1 {
            return "Para:"
        } else if section == 2 {
            return "Valor:"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 85
        } else if indexPath.section == 1 {
            return 45
        } else if indexPath.section == 2 {
            return 120
        }
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTipoConta", for: indexPath) as! TipoContaTableViewCell
            cell.segmentedControl.selectedSegmentIndex = tipoConta
            if tipoConta == 0 {
//                let conta = DataApp.dadosDoUsuario["account"] as! [String:Any]
                cell.saldoLabel.text = "Saldo "+"\(DataApp.usuario.account.balance)".doubleValue.currency
            } else if tipoConta == 1 {
//                let conta = DataApp.dadosDoUsuario["savings"] as! [String:Any]
                cell.saldoLabel.text = "Saldo "+"\(DataApp.usuario.savings.balance)".doubleValue.currency
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellContato", for: indexPath) as! ContatoTableViewCell
            cell.textLabel?.text = "\(contato)"
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellValor", for: indexPath) as! ValorTableViewCell
            cell.valorTextField.delegate = self
            cell.valorTextField.placeholder = "0.00".doubleValue.currency
            
            //setting toolbar as inputAccessoryView
            cell.valorTextField.inputAccessoryView = initToolbar()
            
            cellValor = cell
            return cell
        }

        return UITableViewCell()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = nil
    }
    
    var cellValor = ValorTableViewCell()
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let valorString = cellValor.valorTextField.text, valorString != "" {
            Formatter.currency.locale = Locale.current
            valorTransferencia = valorString.doubleValue
            cellValor.valorTextField.text = "\(valorString.doubleValue.currency)"
        }
    }
    
    func initToolbar() -> UIToolbar {
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Concluído", style: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        return toolbar
    }

    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result = String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}

extension NumberFormatter {
    convenience init(style: Style) {
        self.init()
        self.numberStyle = style
    }
}
extension Formatter {
    static let currency = NumberFormatter(style: .currency)
}
extension FloatingPoint {
    var currency: String {
        return Formatter.currency.string(for: self) ?? ""
    }
}
