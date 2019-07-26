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
    
    static func atualizarDadosDoUsuario(nome:String, completion: @escaping (Bool) -> Void) {
        API.get(option: "usuario/search?name=\(nome)") { response in
            if let data = response as? [[String:Any]] {
                DataApp.dadosDoUsuario = data[0]
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
