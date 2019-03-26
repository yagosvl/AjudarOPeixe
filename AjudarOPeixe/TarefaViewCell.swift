//
//  TarefaViewCell.swift
//  AjudarOPeixe
//
//  Created by student on 26/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class TarefaViewCell: UITableViewCell {
    
    @IBOutlet weak var IsDone: UISwitch!
    
    @IBOutlet weak var Nome: UILabel!
    
    @IBAction func IsDoneAction(_ sender: UISwitch) {
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
