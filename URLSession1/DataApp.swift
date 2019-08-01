//
//  DataApp.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 26/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import Foundation

class DataApp {
    static var contatos: [String] = []
    static var usuario: Usuario!
    static var tipoContaTransferencia = 0
    
    static func atualizarDadosDoUsuario(nome:String, completion: @escaping (Bool?) -> Void) {
        let json = ["name":nome]
        API.searchUser(json: json) { response in
            guard response != nil  else {
                completion(nil)
                return
            }
            if let usuario = response {
                self.usuario = usuario
                print("Dados atualizados. Nome: \(usuario.name)")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

struct Usuario: Codable {
    let name: String
    let transferLimitUsed: Double
    let account: Conta
    let savings: Conta
}

struct Conta: Codable {
    var balance: Double
    var historic: [Transacao]
}

struct Transacao: Codable {
    let description: String
    let value: Double
    let date: String
}
