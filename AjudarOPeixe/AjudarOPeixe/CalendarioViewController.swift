//
//  CalendarioViewController.swift
//  AjudarOPeixe
//
//  Created by student on 27/03/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class CalendarioViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var CalendarioCollectionView: UICollectionView!
    
    @IBOutlet weak var MesLabel: UILabel!
    
    @IBAction func AvancaMes(_ sender: Any) {
        switch MesAtual {
        case "Dezembro":
            MesInfo = 0
            AnoInfo += 1
            Direcao = 1
            PegarDiaInicialPosicao()
            MesAtual = Meses[MesInfo]
            MesLabel.text = "\(Meses[MesInfo]) \(AnoInfo)"
            CalendarioCollectionView.reloadData()
        default:
            Direcao = 1
            PegarDiaInicialPosicao()
            MesInfo += 1
            MesAtual = Meses[MesInfo]
            MesLabel.text = "\(Meses[MesInfo]) \(AnoInfo)"
            CalendarioCollectionView.reloadData()
            
        }
        
        
        
    }
    
    @IBAction func VoltaMes(_ sender: Any) {
        switch MesAtual {
        case "Janeiro":
            MesInfo = 11
            AnoInfo -= 1
            Direcao = -1
            PegarDiaInicialPosicao()
            MesAtual = Meses[MesInfo]
            MesLabel.text = "\(Meses[MesInfo]) \(AnoInfo)"
            CalendarioCollectionView.reloadData()
        default:
            MesInfo -= 1
            Direcao = -1
            PegarDiaInicialPosicao()
            MesAtual = Meses[MesInfo]
            MesLabel.text = "\(Meses[MesInfo]) \(AnoInfo)"
            CalendarioCollectionView.reloadData()
        }
    }
    
    let Meses = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
    var DiasMeses = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30 ,31]
    var MesAtual = String()
    var EspacosVazios = Int()
    var EspacosVazioMesAnterior = 0
    var EspacosVazioMesPosterior = Int()
    var Direcao = 0
    var IndicePosicao = 0
    
    func PegarDiaInicialPosicao(){
        switch Direcao {
        case 0:
            switch DiaInfo {
            case 1...7:
                EspacosVazios = DiaSemanaInfo - DiaInfo
            case 8...14:
                EspacosVazios = (DiaSemanaInfo - DiaInfo - 7)
            case 15...21:
                EspacosVazios = DiaSemanaInfo - DiaInfo - 14
            case 22...28:
                EspacosVazios = DiaSemanaInfo - DiaInfo - 21
            case 29...31:
                EspacosVazios = DiaSemanaInfo - DiaInfo - 28
            default:
            break
            }
            IndicePosicao = EspacosVazios
        case 1...999:
            EspacosVazioMesPosterior = (IndicePosicao + DiasMeses[MesInfo])%7
            IndicePosicao = EspacosVazioMesPosterior
        case -1:
            EspacosVazioMesAnterior = ( 7 - (DiasMeses[MesInfo] - IndicePosicao)%7)
            if EspacosVazioMesAnterior == 7{
                EspacosVazioMesAnterior = 0
            }
            IndicePosicao = EspacosVazioMesAnterior
        default:
            fatalError()
        }
        
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MesAtual = Meses[MesInfo]
        MesLabel.text = "\(MesAtual) \(AnoInfo)"
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direcao {
        case 0:
            return (DiasMeses[MesInfo] + EspacosVazios)
        case 1...999:
            return (DiasMeses[MesInfo] + EspacosVazioMesPosterior)
        case -1:
            return (DiasMeses[MesInfo] + EspacosVazioMesAnterior)
        default:
            fatalError()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendario", for: indexPath) as! CalendarioCollectionViewCell
        if cell.isHidden{
            cell.isHidden = false
        }
        cell.DataLabel.text = "\(indexPath.row + 1)"
        cell.backgroundColor = UIColor.clear
        switch Direcao {
        case 0:
            cell.DataLabel.text = "\(indexPath.row + 1 - EspacosVazios)"
        case 1...999:
            cell.DataLabel.text = "\(indexPath.row + 1 - EspacosVazioMesPosterior)"
        case -1:
            cell.DataLabel.text = "\(indexPath.row + 1 - EspacosVazioMesAnterior)"
        default:
            fatalError()
        }
        if Int(cell.DataLabel.text!)!<1{
            cell.isHidden = true
        }
        
        if MesAtual == Meses[BuscaCalendario.component(.month, from: Data) - 1 ] && AnoInfo == BuscaCalendario.component(.year, from: Data) && (indexPath.row + 1) == DiaInfo {
            cell.backgroundColor = UIColor.red
        }
        
        return cell
        
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
