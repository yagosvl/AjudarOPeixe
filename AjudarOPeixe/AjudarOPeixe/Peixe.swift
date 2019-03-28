//
//  Peixe.swift
//  AjudarOPeixe
//
//  Created by Marcos Lapa dos Santos on 28/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

class Peixe{
    var nome: String
    var login: String
    var tarefas = [Tarefa]()
    
    init(nome: String, login: String){
        self.nome = nome
        self.login = login
    }
    
    func adicionarTarefa(tar: Tarefa){
        if !(tarefas.contains(where: { $0.id == tar.id })){
            tarefas.append(tar)
        }
    }
    
}
