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
    
    /*init(){
        TarefaDAO.tarefas.append(Tarefa(nome: "Arrumar o quarto", data: "22/03/2019 10:00:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Ir ao mercado", data: "23/03/2019 10:30:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Lavar roupa", data: "25/03/2019 09:30:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Estudar inglês", data: "25/03/2019 08:00:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Comprar pão", data: "27/03/2019 09:45:00"))
        TarefaDAO.tarefas.append(Tarefa(nome: "Lavar banheiro", data: "29/03/2019 10:30:00"))
    }*/
    
    static func fillTarefas(){
        self.tarefas.append(Tarefa(nome: "Arrumar o quarto", data: "22/03/2019 10:00:00"))
        self.tarefas.append(Tarefa(nome: "Ir ao mercado", data: "23/03/2019 10:30:00"))
        self.tarefas.append(Tarefa(nome: "Lavar roupa", data: "25/03/2019 09:30:00"))
        self.tarefas.append(Tarefa(nome: "Estudar inglês", data: "25/03/2019 08:00:00"))
        self.tarefas.append(Tarefa(nome: "Comprar pão", data: "26/03/2019 09:45:00"))
        self.tarefas.append(Tarefa(nome: "Lavar banheiro", data: "26/03/2019 10:30:00"))
        self.tarefas.append(Tarefa(nome: "Comprar Sabao", data: "27/03/2019 09:45:00"))
        self.tarefas.append(Tarefa(nome: "Lavar carro", data: "28/03/2019 10:30:00"))
        self.tarefas.append(Tarefa(nome: "Comprar feijao", data: "28/03/2019 09:45:00"))
        self.tarefas.append(Tarefa(nome: "Lavar varanda", data: "29/03/2019 10:30:00"))
    }
    
    static func getAll() -> [Tarefa]{
        return self.tarefas
    }
    
    static func getTarefasPorData(data : String) -> [Tarefa]{
        var tarefasDaData = [Tarefa]()
        for tar in TarefaDAO.getAll() {
            if(tar.data.hasPrefix(data)){
                tarefasDaData.append(tar)
            }
        }
        
        return tarefasDaData
    }
    
    static func getTarefasDoDia() -> [Tarefa]{
        let hoje = Date()
        let result = getDateInStringFormat(date: hoje)
        return getTarefasPorData(data: result)
    }
    
    static func getDateInStringFormat(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    static func addTarefa(tarefa : Tarefa){
        if !(TarefaDAO.getAll().contains(where: { $0.nome == tarefa.nome })){
            TarefaDAO.tarefas.append(tarefa)
        }
    }
    
    static func addSubtarefa(tar: Tarefa, sub: Subtarefa){
        if let tarefa = TarefaDAO.getAll().first(where: { $0.nome == tar.nome }){
            tarefa.subtarefas.append(sub)
        }
    }

    static func updTarefa(tarefa : Tarefa){
        if let tarefaUpd = TarefaDAO.getAll().first(where: { $0.id == tarefa.id }){
            tarefaUpd.nome = tarefa.nome
            tarefaUpd.data = tarefa.data
            tarefaUpd.percentualConcluida = tarefa.percentualConcluida
            tarefaUpd.subtarefas = tarefa.subtarefas
        }
    }
    
    static func delTarefa(idTarefa : Int){
        if !(TarefaDAO.getAll().contains(where: { $0.id == idTarefa })){
            if let indiceRem = TarefaDAO.getAll().index(where: { $0.id == idTarefa }){
                TarefaDAO.tarefas.remove(at: indiceRem)
            }
        }
    }
}
