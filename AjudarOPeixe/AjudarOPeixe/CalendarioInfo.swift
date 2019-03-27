//
//  CalendarioInfo.swift
//  AjudarOPeixe
//
//  Created by student on 27/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

let Data = Date()
let BuscaCalendario = Calendar.current

let DiaInfo = BuscaCalendario.component(.day, from: Data)
var MesInfo = BuscaCalendario.component(.month, from: Data) - 1
var AnoInfo = BuscaCalendario.component(.year, from: Data)
var DiaSemanaInfo = BuscaCalendario.component(.weekday, from: Data)
