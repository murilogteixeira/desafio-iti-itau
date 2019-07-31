//
//  ContatosTableViewController.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 26/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit

class ExtratoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var historico = [Transacao]()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        alterarExtrato(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print(DataApp.dadosDoUsuario)
    }

    @IBAction func alterarExtrato(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
//            let conta = DataApp.dadosDoUsuario["account"] as! [String:Any]
            historico = DataApp.usuario.account.historic
        } else if segmentedControl.selectedSegmentIndex == 1 {
//            let conta = DataApp.dadosDoUsuario["savings"] as! [String:Any]
            historico = DataApp.usuario.savings.historic
        }
        tableView.reloadData()
//        print(historico)
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if segmentedControl.selectedSegmentIndex == 0 {
//            if let conta = DataApp.dadosDoUsuario["account"] as? [String:Any],
//                let historico = conta["historic"] as? [[String:Any]] {
//            }
            return DataApp.usuario.account.historic.count
        } else if segmentedControl.selectedSegmentIndex == 1 {
//            if let conta = DataApp.dadosDoUsuario["savings"] as? [String:Any],
//                let historico = conta["historic"] as? [[String:Any]] {
//                return historico.count
//            }
            return DataApp.usuario.savings.historic.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExtratoTableViewCell
        cell.descricaoLabel.text = (historico[indexPath.row].description)
        cell.dataLabel.text = (historico[indexPath.row].date)
        cell.valorLabel.text = String(historico[indexPath.row].value).doubleValue.currency
        return cell
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
