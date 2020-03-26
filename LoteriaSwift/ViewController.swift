//
//  ViewController.swift
//  LoteriaSwift
//
//  Created by Rafaela on 24/03/20.
//  Copyright © 2020 Rafaela. All rights reserved.
//

import UIKit

enum GameType: String {
    case megaSena = "Mega - Sena", quina = "Quina"
}

infix operator >-<
func >-< (total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    
    while result.count < total {
        let randomNuumber = Int(arc4random_uniform(UInt32(universe))+1)
        if !result.contains(randomNuumber) {
            result.append(randomNuumber)
        }
    }
    
    return result.sorted()
}

class ViewController: UIViewController {

    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumbers(for: .megaSena)
    }
    
    func showNumbers (for type: GameType) {
        lbGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
            case .megaSena:
                game = 6>-<60
                balls.last!.isHidden = false
            case .quina:
                game = 5>-<80
                balls.last!.isHidden = true
        }
        for (index, game) in game.enumerated() {
            balls[index].setTitle("\(game)", for: .normal)
        }
    }

    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex {
        case 0:
            showNumbers(for: .megaSena)
        default:
            showNumbers(for: .quina)
        }
    }
    
}

