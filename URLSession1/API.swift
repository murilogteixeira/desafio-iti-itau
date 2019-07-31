//
//  API.swift
//  URLSession1
//
//  Created by Murilo Teixeira on 24/07/19.
//  Copyright © 2019 Murilo Teixeira. All rights reserved.
//

import Foundation

class API {
    static let session = URLSession.shared
    static let url = "https://api-murilo.mybluemix.net/"
    
    static func getContacts(completion: @escaping ([String]?) -> Void) {
        let query = "usuario/list"
        let prepareUrl = "\(url)\(query)"
        let urlApi = URL(string: prepareUrl)!
        
        let task = session.dataTask(with: urlApi) { data, response, error in
            if let data = self.tratarResposta(data: data, response: response, error: error) {
                do {
                    let decoder = JSONDecoder()
                    let contatos = try decoder.decode([String].self, from: data)
                    completion(contatos)
                } catch {
                    print("Erro ao buscar contatos: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    static func searchUser(json: [String:String?], completion: @escaping (Usuario?) -> Void) {
        let query = "usuario/search"
        let prepareUrl = "\(url)\(query)"
        let urlApi = URL(string: prepareUrl)!
        var request = URLRequest(url: urlApi)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift", forHTTPHeaderField: "X-Powered-By")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        print(jsonData)
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            if let data = self.tratarResposta(data: data, response: response, error: error) {
                do {
                    let decoder = JSONDecoder()
//                    print(try JSONSerialization.jsonObject(with: data, options: []))
                    let usuario = try decoder.decode(Usuario.self, from: data)
                    completion(usuario)
                } catch {
                    print("Erro ao buscar usuario: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    static func novoUsuario(json: [String:String?], completion: @escaping (Bool?) -> Void) {
        let query = "usuario/new"
        let prepareUrl = "\(url)\(query)"
        let urlApi = URL(string: prepareUrl)!
        var request = URLRequest(url: urlApi)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift", forHTTPHeaderField: "X-Powered-By")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            if let data = self.tratarResposta(data: data, response: response, error: error) {
                if let data = self.tratarResposta(data: data, response: response, error: error) {
                    do {
                        let decoder = JSONDecoder()
                        let usuario = try decoder.decode(Usuario.self, from: data)
                        if usuario.name == json["name"] {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    } catch {
                        print("Erro ao buscar usuario: \(error.localizedDescription)")
                        completion(nil)
                    }
                } else {
                    completion(false)
                }
//                if resposta["name"] as? String == json["name"] {
//                    completion(true)
//                } else {
//                    completion(false)
//                }
            }
        }
        task.resume()
    }
    
    static func delete(option: String, json: [String:String?]) {
        let prepareUrl = "\(url)\(option)"
        let urlApi = URL(string: prepareUrl)!
        var request = URLRequest(url: urlApi)
        request.httpMethod = "DELETE"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift", forHTTPHeaderField: "X-Powered-By")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            let reposta = self.tratarResposta(data: data, response: response, error: error)
            print(reposta ?? "")
        }
        task.resume()
    }
    
    static func transfer(option: String, json: [String:Any?], completion: @escaping (Bool?) -> Void) {
        let prepareUrl = "\(url)\(option)"
        let urlApi = URL(string: prepareUrl)!
        var request = URLRequest(url: urlApi)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift", forHTTPHeaderField: "X-Powered-By")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            if let data = self.tratarResposta(data: data, response: response, error: error) {
//                let json = try! JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//                if resposta["name"] as? String == json["name"] as? String {
//                    completion(true)
//                } else {
//                    completion(false)
//                }
                completion(true)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    static func tratarResposta(data: Data?, response: URLResponse?, error: Error?) -> Data? {
        // verifica se houve erro
        guard error == nil else {
            print("Ocorreu um erro. \(String(describing: error))")
            return nil
        }
        
        // verifica o status code da resposta
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            return nil
        }
        print("StatusCode: \(httpResponse.statusCode)")
        
        // verificar se a resposta é do tipo json
        guard let mime = response?.mimeType, mime == "application/json" else {
            print("Tipo MIME incorreto")
            return nil
        }
        
        // converte os dados da resposta do tipo binário para json
//        var json: Any!
//        do {
//            json = try JSONSerialization.jsonObject(with: data!, options: [])
//            // salva a lista para visualizar
////            return json
//        } catch {
//            print("JSON error: \(error.localizedDescription)")
//        }
        return data
    }
}
