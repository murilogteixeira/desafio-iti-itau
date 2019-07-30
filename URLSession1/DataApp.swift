//
//  DataApp.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 26/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import Foundation

class DataApp {
    static var dadosDoUsuario = [String:Any]()
    static var contatos = [String]()
    
    static func atualizarDadosDoUsuario(nome:String, completion: @escaping (Bool) -> Void) {
        let json = ["name":nome]
        API.search(option: "usuario/search", json: json) { response in
            if let data = response {
                DataApp.dadosDoUsuario = data
                print("Dados atualizados. Nome: \(DataApp.dadosDoUsuario["name"] as! String)")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
