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
    
    /*
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
    }*/
    
    /*
    static func getTarefas(callback: @escaping ((Tarefa) -> Void)) {
        
        let endpoint: String = "https://ajudaropeixenodered.mybluemix.net/tarefa/getall"
        
        guard let url = URL(string: endpoint) else {
            print("Erroooo: Cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error = \(String(describing: error))")
                return
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(String(describing: responseString))")
            
            DispatchQueue.main.async() {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                        
                        let tarefa = Tarefa(json: json[0])
                        
                        let nomeTarefa = tarefa.nome
                        let dataTarefa = tarefa.data
                        
                        print("\(nomeTarefa) prevista para o dia/horário: \(dataTarefa).")
                        
                        callback(tarefa)
                        
                    }else {
                        
                        print("Erro ao buscar dados do Json")
                    }
                } catch let error as NSError {
                    print("Error = \(error.localizedDescription)")
                }
            }
            
        })
        
        task.resume()
    }

    static func getAllFromCloud(callback: @escaping (([Tarefa]) -> ())) {
        
        let endpoint: String = "https://ajudaropeixenodered.mybluemix.net/tarefa/getAll"
        
        guard let url = URL(string: endpoint) else {
            print("Erroooo: Cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        var tarefasCloud = [Tarefa]()
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error = \(String(describing: error))")
                return
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(String(describing: responseString))")
            
            DispatchQueue.main.async() {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                        
                        
                        for tarefaJson in json{
                            let tarefa = Tarefa(json: tarefaJson)
                            print("\(tarefa.nome) prevista para o dia/horário: \(tarefa.data).\n")
                            tarefasCloud.append(tarefa)
                        }
            
                        callback(tarefasCloud)
                        
                    }else {
                        
                        print("Erro ao buscar dados do Json")
                    }
                } catch let error as NSError {
                    print("Error = \(error.localizedDescription)")
                }
            }
            
        })
        
        task.resume()
    }
    */
    
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
    
    static func addTarefa(tarefa : Tarefa){
        //tarefa.id = TarefaDAO.tarefas[TarefaDAO.tarefas.count-1].id+1
        TarefaDAO.tarefas.append(tarefa)
        
            // prepare json data
        
        let json : [String: Any] = ["id": tarefa.id,
                                    "nome": "\(tarefa.nome)",
                                    "data": "\(tarefa.data)",
                                    "percentualConcluida": 0]
        
        //"{\"id\":\(tarefa.id),\"nome\":\"\(tarefa.nome)\",\"data\":\"\(tarefa.data)\",\"percentualConcluida\":\(0)}"
            
            print("json gerado: \(json)")
        
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            // create post request
            let url = URL(string: "https://ajudaropeixenodered.mybluemix.net/tarefa/ins")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // insert json data to the request
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }
            
            task.resume()
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
}
