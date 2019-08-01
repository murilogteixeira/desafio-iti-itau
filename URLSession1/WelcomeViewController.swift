//
//  WelcomeViewController.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 24/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func acessarConta(_ sender: Any) {
        View.showInputAlert(title: "Login", message: "Insira o seu nome cadastrado na conta:", placeholder: "Digite o seu nome", viewController: self, completion: { nome in
            // Mostra a tela de loading
            View.loadingView(show: true, showLoading: true, view: self.view)
            // Verifica se existe um usuario com o nome inserido
            let json = ["name":nome]
            API.searchUser(json: json, completion: { response in
                // Verifica se o usuario foi encontrado
                if let user = response {
                    DataApp.atualizarDadosDoUsuario(nome: user.name, completion: { success in
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
                            API.novoUsuario(json: json, completion: { success in
                                guard success != nil  else {
                                    View.showOkAlert(title: "Erro", message: "Ocorreu um erro na comunicação com o servidor", viewController: self, completion: {})
                                    return
                                }
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
            API.searchUser(json: json, completion: { response in
                // Verifica se o nome já existe
                if let user = response {
                    // Desabilita a tela de loading
                    View.loadingView(show: false, view: self.view)
                    View.showBoolAlert(title: "Erro", message: "Usuário \"\(nome)\" já cadastrado! Deseja acessar a conta?", viewController: self, completion: { success in
                        // Acessa a conta do usuario existente
                        if success {
                            DataApp.atualizarDadosDoUsuario(nome: user.name, completion: { atualizado in
                                self.vaiParaApp()
                            })
                        }
                    })
                } else {
                    // Desabilita a tela de loading
                    View.loadingView(show: false, view: self.view)
                    // Realizar o cadastro
                    API.novoUsuario(json: json, completion: { success in
                        guard success != nil  else {
                            View.showOkAlert(title: "Erro", message: "Ocorreu um erro na comunicação com o servidor", viewController: self, completion: {})
                            return
                        }
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
    func search(nome: String, completion: @escaping (Bool, Usuario?) -> Void) {
        API.searchUser(json: ["name":nome]) { response in
            guard response != nil else {
                View.showOkAlert(title: "Erro", message: "Ocorreu um erro na comunicação com o servidor", viewController: self, completion: {})
                return
            }
            if let user = response, user.name == nome {
                completion(true, user)
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
}
