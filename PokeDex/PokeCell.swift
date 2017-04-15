//
//  PokeCell.swift
//  PokeDex
//
//  Created by Mac on 4/15/17.
//  Copyright © 2017 xerox101. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage:UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    
    var pokemon:Pokemon!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        layer.cornerRadius = 5.0
    }
    
    func configCell(pokemon:Pokemon){
        
        self.pokemon = pokemon;
        nameLabel.text = pokemon.name.capitalized
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
        
    }
    
}
