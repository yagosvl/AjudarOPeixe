//
//  TarefaDAO.swift
//  AjudarOPeixe
//
//  Created by student on 22/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: url) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
}

class TarefaDAO{
    static var tarefas = [Tarefa]()
    
    static func getTarefasFromCloud() -> [Tarefa] {
        let url = URL(string: "https://ajudaropeixenodered.mybluemix.net/tarefa/getAll")!
        
        let (data, _, error) = URLSession.shared.synchronousDataTask(with: url)
        
        if error != nil {
            return []
        } else {
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String: AnyObject]]
            var tarefasCloud = [Tarefa]()
            for tarefaJson in json{
                let tarefa = Tarefa(json: tarefaJson)
                print("\(tarefa.nome) prevista para o dia/horário: \(tarefa.data); concluida: \(tarefa.percentualConcluida).\n")
                tarefasCloud.append(tarefa)
            }
            return tarefasCloud
        }
    }
    
    static func getAll() -> [Tarefa]{
        let tars = getTarefasFromCloud()

        return tars
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
    
    static func updTarefa(tarefa : Tarefa){
        if let tarefaUpd = TarefaDAO.getAll().first(where: { $0.id == tarefa.id }){
            tarefaUpd.nome = tarefa.nome
            tarefaUpd.data = tarefa.data
            tarefaUpd.percentualConcluida = tarefa.percentualConcluida
        }
    }
    
    static func delTarefa(idTarefa : Int){
        if !(TarefaDAO.getAll().contains(where: { $0.id == idTarefa })){
            if let indiceRem = TarefaDAO.getAll().index(where: { $0.id == idTarefa }){
                TarefaDAO.tarefas.remove(at: indiceRem)
            }
        }
    }
    
    static func addTarefa(tarefa : Tarefa){
        //tarefa.id = TarefaDAO.tarefas[TarefaDAO.tarefas.count-1].id+1
        TarefaDAO.tarefas.append(tarefa)
        
        // prepare json data
        let jsonEnc = "{\"id\":\(tarefa.id),\"nome\":\"\(tarefa.nome)\",\"data\":\"\(tarefa.data)\",\"percentualConcluida\":\(0)}"
        
        let data = jsonEnc.data(using: .utf8)!
        
        print("json gerado: \(data)")
        
        
        //let jsonData = try? JSONSerialization.data(withJSONObject: jsonEnc)
        
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: AnyObject] //[Dictionary<String,AnyObject>]
            {
                print("=====>jsonArray:\(jsonArray)") // use the json here
                //let jsonData = try? JSONSerialization.data(withJSONObject: jsonArray)
                
                
                // create post request
                let url = URL(string: "https://ajudaropeixenodered.mybluemix.net/tarefa/ins")!
                
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

