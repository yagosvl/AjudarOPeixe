//
//  PeixeDAO.swift
//  AjudarOPeixe
//
//  Created by Marcos Lapa dos Santos on 28/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

class PeixeDAO{
    
    
    static func getTarefasDoDia(login: String) -> [Tarefa]{
        
        let tarefasDoDia = TarefaDAO.getTarefasDoDia()
        return tarefasDoDia
    }
}
