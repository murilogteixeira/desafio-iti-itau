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
        View.showInputAlert(title: "Insira o seu nome conforme cadastrado em sua conta:", message: nil, placeholder: "Digite o seu nome", viewController: self, completion: { nome in
            // Mostra a tela de loading
            View.loadingView(show: true, showLoading: true, view: self.view)
            // Verifica se existe um usuario com o nome inserido
            self.search(nome: nome, completion: { success in
                // Desabilita a tela de loading
                View.loadingView(show: false, view: self.view)
                // Verifica se o usuario foi encontrado
                if success {
                    self.vaiParaApp()
                } else {
                    View.showBoolAlert(title: "Usuário \"\(nome)\" não cadastrado! Deseja cadastrar?", message: nil, viewController: self, completion: { success in
                        // Cadastrar um novo usuario caso nao exista
                        if success {
                            View.loadingView(show: true, showLoading: true, view: self.view)
                            let json = ["name":nome]
                            API.post(option: "usuario/new", json: json, completion: { success in
                                View.loadingView(show: false, view: self.view)
                                DataApp.atualizarDadosDoUsuario(nome: nome, completion: { atualizado in
                                    print("Dados atualizados. Nome: \(DataApp.dadosDoUsuario["name"] as! String)")
                                })
                                View.showOkAlert(title: "Usuário cadastrado!", message: nil, viewController: self, completion: {
                                    self.vaiParaApp()
                                })
                            })
                        }
                    })
                }
            })
        })
    }
    
    @IBAction func criarConta(_ sender: Any) {
        View.showInputAlert(title: "Insira o seu nome para cadastrar:", message: nil, placeholder: "Digite o seu nome", viewController: self, completion: { nome in
            // Mostra a tela de loading
            View.loadingView(show: true, showLoading: true, view: self.view)
            // Verifica se existe um usuario com o nome inserido
            self.search(nome: nome, completion: { success in
                // Desabilita a tela de loading
                View.loadingView(show: false, view: self.view)
                // Verifica se o nome já existe
                if success {
                    View.showBoolAlert(title: "Usuário \"\(nome)\" já cadastrado! Deseja acessar a conta?", message: nil, viewController: self, completion: { success in
                        // Acessa a conta do usuario existente
                        if success {
                            self.vaiParaApp()
                        }
                    })
                } else {
                    // Realizar o cadastro
                    let json = ["name":nome]
                    API.post(option: "usuario/new", json: json, completion: { success in
                        View.showOkAlert(title: "Usuário cadastrado!", message: nil, viewController: self, completion: {
                            DataApp.atualizarDadosDoUsuario(nome: nome, completion: { atualizado in
                                print("Dados atualizados. Nome: \(DataApp.dadosDoUsuario["name"] as! String)")
                            })
                            self.vaiParaApp()
                        })
                    })
                }
            })
        })
    }
    
    // Procura um nome cadastrado
    func search(nome: String, completion: @escaping (Bool) -> Void) {
        DataApp.atualizarDadosDoUsuario(nome: nome, completion: { atualizado in
            if atualizado {
                print("Dados atualizados. Nome: \(DataApp.dadosDoUsuario["name"] as! String)")
            }
            completion(atualizado)
        })
//        API.get(option: "usuario/search?name=\(nome)", completion: { response in
//            if let user = response as? [[String : Any]], user.count != 0, user[0]["name"] as! String == nome {
//                completion(user[0])
//            } else {
//                completion(nil)
//            }
//        })
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
