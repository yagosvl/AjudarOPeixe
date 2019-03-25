//
//  TarefaDAOTestador.swift
//  AjudarOPeixe
//
//  Created by student on 25/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import XCTest
@testable import AjudarOPeixe

class TarefaDAOTestador: XCTestCase {
    
    var tarefas = [Tarefa]()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        TarefaDAO.fillTarefas()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        TarefaDAO.tarefas = [Tarefa]()
    }
    
    func testGetAll(){
        tarefas = TarefaDAO.getAll()
        XCTAssertEqual(tarefas.count, 6)
        
    }
    
    func testGetDateInStringFormat(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let someDateTime = formatter.date(from: "25/03/2019 00:00")
        XCTAssertEqual(TarefaDAO.getDateInStringFormat(date: someDateTime!), "25/03/2019")
    }
    
    func testGetTarefasPorData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let tarefasPorData = TarefaDAO.getTarefasPorData(data: "25/03/2019")
        XCTAssertEqual(tarefasPorData.count, 2)
        XCTAssertEqual(tarefasPorData[0].nome, "Lavar roupa")
        XCTAssertEqual(tarefasPorData[1].nome, "Estudar inglês")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
