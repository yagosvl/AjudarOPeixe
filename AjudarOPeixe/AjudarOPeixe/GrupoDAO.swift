//
//  GrupoDAO.swift
//  AjudarOPeixe
//
//  Created by Rodrigo Paixão on 29/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

public class Grupo{
    var id : Int
    var nome : String
    var tarefas = [Tarefa]()
    
    init(nome : String) {
        self.nome = nome
        self.id = 0
    }
    
    init(json: [String: AnyObject]) {
        self.id = json["id"] as? Int ?? 0
        self.nome = json["nome"] as? String ?? ""
        
        self.tarefas = [Tarefa]()
        
        if let tars = json["tarefas"] as? [ [String: AnyObject] ] {
            for jsonTarefa in tars {
                let novaTarefa = Tarefa(json: jsonTarefa)
                self.tarefas.append(novaTarefa)
            }
        }
    }
}

class GrupoDAO{
    static var grupos = [Grupo]()
    
    static func getGruposFromCloud() -> [Grupo] {
        let url = URL(string: "https://ajudaropeixenodered.mybluemix.net/grupo/getAll")!
        
        let (data, _, error) = URLSession.shared.synchronousDataTask(with: url)
        
        if error != nil {
            return []
        } else {
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String: AnyObject]]
            var gruposCloud = [Grupo]()
            for grupoJson in json{
                let grupo = Grupo(json: grupoJson)
                print("Grupo: \(grupo.nome).\n")
                if(grupo.nome.starts(with: "Grupo")){
                    gruposCloud.append(grupo)
                }
            }
            return gruposCloud
        }
    }
    
    static func getAll() -> [Grupo]{
        let grps = getGruposFromCloud()
        return grps
    }
    
    static func addGrupo(grupo : Grupo){
        GrupoDAO.grupos.append(grupo)
        
        // prepare json data
        let jsonEnc = "{\"id\":\(grupo.id),\"nome\":\"\(grupo.nome)\",\"tarefas\":[]}"
        
        let data = jsonEnc.data(using: .utf8)!
        
        //print("json gerado: \(data)")
        
        
        //let jsonData = try? JSONSerialization.data(withJSONObject: jsonEnc)
        
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: AnyObject] //[Dictionary<String,AnyObject>]
            {
                print("=====>jsonArray:\(jsonArray)") // use the json here
                //let jsonData = try? JSONSerialization.data(withJSONObject: jsonArray)
                
                
                // create post request
                let url = URL(string: "https://ajudaropeixenodered.mybluemix.net/grupo/ins")!
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                var headers = request.allHTTPHeaderFields ?? [:]
                headers["Content-Type"] = "application/json"
                request.allHTTPHeaderFields = headers
                
                // insert json data to the request
                request.httpBody = data//jsonData
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        //print(error?.localizedDeion ?? "No data")
                        return
                    }
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        print("response ======> \(responseJSON)")
                    }
                }
                
                
                task.resume()
            } else {
                print("=====>bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        
    }
    
}
