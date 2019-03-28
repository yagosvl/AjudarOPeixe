//
//  File.swift
//  AjudarOPeixe
//
//  Created by student on 22/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

public class Tarefa{
    var id : Int
    var nome : String
    var data : String
    var percentualConcluida : Float
    
    init(nome : String, data: String) {
        self.nome = nome
        self.data = data
        self.percentualConcluida = 0.0
        self.id = 0        
    }
    
    init(json: [String: AnyObject]) {
        self.id = json["id"] as? Int ?? 0
        self.nome = json["nome"] as? String ?? ""
        self.data = json["data"] as? String ?? ""
        self.percentualConcluida = json["proprietario"] as? Float ?? 0.0
    
        /*self.carro = [Carro]()
    
        if let carros = json["carro"] as? [ [String: String] ] {
            for jsonCarro in carros {
                let novoCarro = Carro(json: jsonCarro)
                self.carro.append(novoCarro)
            }
        }*/
    }
}

public class Subtarefa{
    var nome : String
    var isFeita : Bool
    
    init(nome : String) {
        self.isFeita = false
        self.nome = nome
    }
}
