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
        TarefaDAO.tarefas.append(Tarefa(nome: "Arrumar o quarto", data: "22/03/2019 10:00:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Ir ao mercado", data: "23/03/2019 10:30:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Lavar roupa", data: "25/03/2019 09:30:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Estudar inglês", data: "25/03/2019 08:00:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Comprar pão", data: "27/03/2019 09:45:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Lavar banheiro", data: "29/03/2019 10:30:00"))
    }
    
    static func getAll() -> [Tarefa]{
        return self.tarefas
    }
    
    static func addTarefa(tarefa : Tarefa){
        if !(TarefaDAO.tarefas.contains(where: { $0.nome == tarefa.nome })){
            TarefaDAO.tarefas.append(tarefa)
        }
    }
    
    static func addSubtarefa(tar: Tarefa, sub: Subtarefa){
        if let tarefa = TarefaDAO.tarefas.first(where: { $0.nome == tar.nome }){
            tarefa.subtarefas.append(sub)
        }
    }

    static func updTarefa(tarefa : Tarefa){
        if let tarefaUpd = TarefaDAO.tarefas.first(where: { $0.id == tarefa.id }){
            tarefaUpd.nome = tarefa.nome
            tarefaUpd.data = tarefa.data
            tarefaUpd.percentualConcluida = tarefa.percentualConcluida
            tarefaUpd.subtarefas = tarefa.subtarefas
        }
    }
    
    static func delTarefa(idTarefa : Int){
        if !(TarefaDAO.tarefas.contains(where: { $0.id == idTarefa })){
            if let indiceRem = TarefaDAO.tarefas.index(where: { $0.id == idTarefa }){
                TarefaDAO.tarefas.remove(at: indiceRem)
            }
        }
    }
}
