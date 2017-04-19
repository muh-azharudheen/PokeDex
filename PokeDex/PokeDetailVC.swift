//
//  PokeDetailVC.swift
//  PokeDex
//
//  Created by Mac on 4/17/17.
//  Copyright © 2017 xerox101. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {

    var detailedPokemon:Pokemon!
    
    
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var heightLbl: UILabel!

    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var idLbl: UILabel!
    
    @IBOutlet weak var defenseLbl: UILabel!

    @IBOutlet weak var baseAttackLbl: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


      
        self.navigationItem.title = detailedPokemon.name
        
        
        detailedPokemon.downloadPokemonDetail {
           
           print("hello")
            self.updateUI()
            
        }
    }

    func updateUI(){
        
        idLbl.text = "\(detailedPokemon.pokedexId)"
        heightLbl.text = detailedPokemon.height
        weightLbl.text = detailedPokemon.weight
        defenseLbl.text = detailedPokemon.defense
        baseAttackLbl.text = detailedPokemon.baseAttack
    }
}
