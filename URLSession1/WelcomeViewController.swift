//
//  WelcomeViewController.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 24/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    var contatos = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func acessarConta(_ sender: Any) {
        View.showInputAlert(title: "Login", message: "Insira o seu nome cadastrado na conta:", placeholder: "Digite o seu nome", viewController: self, completion: { nome in
            // Mostra a tela de loading
            View.loadingView(show: true, showLoading: true, view: self.view)
            // Verifica se existe um usuario com o nome inserido
            let json = ["name":nome]
            API.search(option: "usuario/search", json: json, completion: { response in
                // Verifica se o usuario foi encontrado
                if let user = response {
                    DataApp.atualizarDadosDoUsuario(nome: user["name"] as! String, completion: { success in
                        // Desabilita a tela de loading
                        View.loadingView(show: false, view: self.view)
                        self.vaiParaApp()
                    })
                } else {
                    View.loadingView(show: false, view: self.view)
                    View.showBoolAlert(title: "Erro", message: "Usuário \"\(nome)\" não cadastrado! Deseja cadastrar?", viewController: self, completion: { success in
                        // Cadastrar um novo usuario caso nao exista
                        if success {
                            View.loadingView(show: true, showLoading: true, view: self.view)
                            let json = ["name":nome]
                            API.post(option: "usuario/new", json: json, completion: { success in
                                DataApp.atualizarDadosDoUsuario(nome: nome, completion: { atualizado in
                                    View.showOkAlert(title: "Usuário cadastrado!", message: nil, viewController: self, completion: {
                                        self.vaiParaApp()
                                    })
                                })
                            })
                        }
                    })
                }
            })
        })
    }
    
    @IBAction func criarConta(_ sender: Any) {
        View.showInputAlert(title: "Criar Conta", message: "Insira o seu nome para cadastrar:", placeholder: "Digite o seu nome", viewController: self, completion: { nome in
            // Mostra a tela de loading
            View.loadingView(show: true, showLoading: true, view: self.view)
            // Verifica se existe um usuario com o nome inserido
            let json = ["name":nome]
            API.search(option: "usuario/search", json: json, completion: { response in
                // Verifica se o nome já existe
                if let user = response {
                    // Desabilita a tela de loading
                    View.loadingView(show: false, view: self.view)
                    View.showBoolAlert(title: "Erro", message: "Usuário \"\(nome)\" já cadastrado! Deseja acessar a conta?", viewController: self, completion: { success in
                        // Acessa a conta do usuario existente
                        if success {
                            DataApp.atualizarDadosDoUsuario(nome: user["name"] as! String, completion: { atualizado in
                                self.vaiParaApp()
                            })
                        }
                    })
                } else {
                    // Desabilita a tela de loading
                    View.loadingView(show: false, view: self.view)
                    // Realizar o cadastro
                    API.post(option: "usuario/new", json: json, completion: { success in
                        View.showOkAlert(title: "Usuário cadastrado!", message: nil, viewController: self, completion: {
                            DataApp.atualizarDadosDoUsuario(nome: nome, completion: { atualizado in
                                self.vaiParaApp()
                            })
                        })
                    })
                }
            })
        })
    }
    
    // Procura um nome cadastrado
    func search(nome: String, completion: @escaping (Bool, [String:Any]?) -> Void) {
        API.get(option: "usuario/search?name=\(nome)") { jsonResponse in
            if let user = jsonResponse as? [[String : Any]], user.count != 0, user[0]["name"] as! String == nome {
                completion(true, user[0])
            } else {
                completion(false, nil)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // fecha o teclado
        self.view.endEditing(true)
    }
    
    // captura o botao DONE do teclado para fechá-lo
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func vaiParaApp() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "vaiParaTransferencia", sender: self)
            
        }
    }
    
    
    func delay(_ seconds: Double, completion: @escaping () -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
}
