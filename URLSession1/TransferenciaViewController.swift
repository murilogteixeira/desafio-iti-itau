//
//  TransferenciaTableViewController.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 26/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit

class TransferenciaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var contatos = [String]()
    var selectedCell: UITableViewCell? = UITableViewCell()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var saldoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let conta = DataApp.dadosDoUsuario["account"] as! [String:Any]
        saldoLabel.text = "R$ \(conta["balance"] as! Double)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        View.loadingView(show: true, showLoading: true, view: self.view)
        API.get(option: "usuario/list") { contatos in
            View.loadingView(show: false, view: self.view)
            if let dados = contatos as? [String:[String]],
                let nomes = dados["nomes"] {
                for nome in nomes {
                    if nome != DataApp.dadosDoUsuario["name"] as! String {
                        self.contatos.append(nome)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    @IBAction func alterarConta(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            let conta = DataApp.dadosDoUsuario["account"] as! [String:Any]
            saldoLabel.text = "R$ \(conta["balance"] as! Double)"
        } else if segmentedControl.selectedSegmentIndex == 1 {
            let poupanca = DataApp.dadosDoUsuario["savings"] as! [String:Any]
            saldoLabel.text = "R$ \(poupanca["balance"] as! Double)"
        }
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contatos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = contatos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell?.accessoryType = .none
        selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
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
