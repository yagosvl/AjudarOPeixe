//
//  TarefaDAO.swift
//  AjudarOPeixe
//
//  Created by student on 22/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

class TarefaDAO{
    static var tarefas = [Tarefa]()
    
    init(){
        TarefaDAO.tarefas.append(Tarefa(nome: "Teste tarefa 1", data: "22/03/2019 10:00:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Teste tarefa 2", data: "23/03/2019 10:30:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Teste tarefa 3", data: "25/03/2019 09:30:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Teste tarefa 4", data: "25/03/2019 08:00:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Teste tarefa 5", data: "27/03/2019 09:45:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Teste tarefa 6", data: "29/03/2019 10:30:00"))
    }
    
    static func getAll() -> [Tarefa]{
        return self.tarefas
    }
    
    static func addTarefa(tarefa : Tarefa){
        if !(TarefaDAO.tarefas.contains(where: { $0.nome == tarefa.nome })){
            TarefaDAO.tarefas.append(tarefa)
        }
    }

    static func updTarefa(tarefa : Tarefa){
        if !(TarefaDAO.tarefas.contains(where: { $0.nome == tarefa.nome })){
            //TarefaDAO.tarefas.re.append(tarefa)
        }
    }
    
    static func delTarefa(idTarefa : Int){
        if !(TarefaDAO.tarefas.contains(where: { $0.id == idTarefa })){
            //let indiceRem? = TarefaDAO.tarefas.index(where: { $0.id == idTarefa })
            //TarefaDAO.tarefas.remove(at: )
        }
    }
}
