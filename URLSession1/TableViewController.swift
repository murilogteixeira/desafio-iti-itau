//
//  ContatosTableViewController.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 26/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let userDefaults = UserDefaults.standard
    let dadosUserDefaults = "dadosUserDefaults"
    let api = API()
    var contatos = [String]()
    var nomeUsuario = ""
    
    var dadosTableView = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        View.loadingView(show: true, showLoading: true, view: self.view)
        tratarDadosTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = self.userDefaults.dictionary(forKey: self.dadosUserDefaults) {
            nomeUsuario = user["name"] as! String
        }
        
        API.get(option: "usuario/list") { users in
            if let dados = users as? [String:[String]],
                let nomes = dados["nomes"] {
                for nome in nomes {
                    if nome != self.nomeUsuario {
                        self.contatos.append(nome)
                    }
                }
                DispatchQueue.main.async {
                    View.loadingView(show: false, view: self.view)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tratarDadosTableView() -> Any? {
        if let comando = dadosTableView["dados"] as? String,
            comando == "dados" {
            print(comando)
        }
        return nil
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contatos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = contatos[indexPath.row]

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
