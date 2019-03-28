//
//  EditarTarefaViewController.swift
//  AjudarOPeixe
//
//  Created by student on 27/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class EditarTarefaViewController: UIViewController {
    
    var tarefaEdicao = Tarefa(nome: "", data: "")

    @IBOutlet weak var LabelIdTarefa: UILabel!
    
    @IBOutlet weak var NomeTextField: UITextField!
    
    @IBOutlet weak var TarefaDatePicker: UIDatePicker!
    
    @IBOutlet weak var TarefaProgress: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LabelIdTarefa.text = String(tarefaEdicao.id)
        
        NomeTextField.text = String(tarefaEdicao.nome)
        
        let Formatter = DateFormatter()
        
        Formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        let tarefaDate = Formatter.date (from: tarefaEdicao.data)
        
        TarefaDatePicker.datePickerMode = .date
        
        TarefaDatePicker.date = tarefaDate!
        print(tarefaEdicao.percentualConcluida)
        TarefaProgress.setProgress(tarefaEdicao.percentualConcluida, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
