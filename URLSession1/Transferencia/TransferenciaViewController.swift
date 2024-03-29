//
//  TransferenciaTableViewController.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 26/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit

class TransferenciaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedIndexPath: IndexPath?
    var selectedContact: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        atualizarContatos()
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        navigationItem.rightBarButtonItem = add
    }
    
    @objc func addTapped() {
        View.showInputAlert(title: "Adicionar Contato", message: "Insira o nome do contato para adicionar:", placeholder: "Digite o nome do contato", viewController: self) { nomeContato in
            
            API.searchUser(json: ["name" : nomeContato], completion: { user in
                guard user != nil  else {
                    View.showOkAlert(title: "Erro", message: "Ocorreu um erro na comunicação com o servidor", viewController: self, completion: {})
                    return
                }
                if user == nil {
                    API.novoUsuario(json: ["name" : nomeContato], completion: { success in
                        if success != nil {
                            View.showOkAlert(title: "Usuário cadastrado!", message: nil, viewController: self, completion: {})
                            self.atualizarContatos()
                        } else {
                            View.showOkAlert(title: "Erro", message: "Ocorreu um erro na comunicação com o servidor", viewController: self, completion: {})
                        }
                    })
                } else {
                    View.showOkAlert(title: "Usuário já cadastrado", message: nil, viewController: self, completion: {})
                }
            })
        }
    }
    
    func atualizarContatos(){
        View.loadingView(show: true, showLoading: true, view: self.view)
        API.getContacts() { contatos in
            guard contatos != nil  else {
                View.showOkAlert(title: "Erro", message: "Ocorreu um erro na comunicação com o servidor", viewController: self, completion: {})
                return
            }
            View.loadingView(show: false, view: self.view)
            if var nomes = contatos {
                let username = DataApp.usuario.name
                for i in 0..<nomes.count {
                    if nomes[i] == username {
                        nomes.remove(at: i)
                        break
                    }
                }
                nomes.sort()
                DataApp.contatos = nomes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                View.showOkAlert(title: "Erro", message: "Ocorreu um erro na comunicação com o servidor", viewController: self, completion: {})
            }
        }
    }
    
    @IBAction func continuar(_ sender: Any) {
        if selectedIndexPath == nil {
            View.showOkAlert(title: "Selecione um contato.", message: nil, viewController: self, completion: {})
        } else {
            self.performSegue(withIdentifier: "vaiConfirmarTransferencia", sender: self)
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 85
        } else if indexPath.section == 1 {
            return 45
        }
        return 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "De:"
        } else if section == 1 {
            return "Para:"
        }
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else if section == 1 {
            return DataApp.contatos.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellConta", for: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellContatos", for: indexPath)
            cell.textLabel?.text = DataApp.contatos[indexPath.row]
            if indexPath.row == selectedIndexPath?.row {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            var selectedCell: UITableViewCell?
            if let selectedIndexPath = selectedIndexPath {
                selectedCell = tableView.cellForRow(at: selectedIndexPath)
                selectedCell?.accessoryType = .none
            }
            selectedCell = tableView.cellForRow(at: indexPath)
            selectedCell?.accessoryType = .checkmark
            selectedIndexPath = indexPath
            selectedContact = selectedCell?.textLabel?.text
        }
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard segue.destination is ConfirmarTranferenciaViewController else {
            print("destino nao é confirmar transferencia")
            return
        }
        guard let vc = segue.destination as? ConfirmarTranferenciaViewController else {
            print("nao foi possivel instanciar ConfirmarTranferenciaViewController")
            return
        }
        guard let contato = selectedContact else {
            print("contato nao selecionado")
            return
        }
        vc.tipoConta = DataApp.tipoContaTransferencia
        vc.contato = contato
    }


}
