//
//  Pokemon.swift
//  PokeDex
//
//  Created by Mac on 4/15/17.
//  Copyright © 2017 xerox101. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon{
    
    private var _name :String!
    private var _pokedexId:Int!
    private var description:String!
    private var type :String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _baseAttack:String!
    private var nextEvolutionText:String!   
    private var _pokemonURL:String!
    
    
    var name:String{
        
        return _name
    }
    
    var pokedexId:Int{
                
        return _pokedexId
    }
    
    var height:String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    var weight:String{
        
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var defense:String{

        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    var baseAttack:String{
        if _baseAttack == nil{
            _baseAttack = ""
        }
        return _baseAttack
    }
    
    
    
    
    
    init(name:String,pokedexId:Int){
        
        self._name = name
        self._pokedexId = pokedexId
        
        
        self._pokemonURL = "\(BASE_URL)\(POKE_URL)\(self.pokedexId)";
        
        
    }
    func downloadPokemonDetail(completed:@escaping DownloadComplete){
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
           
            
            if let Dict = response.result.value as? Dictionary<String,AnyObject>{
                
                if let weight = Dict["weight"] as?  String{
                    
                    self._weight = weight
                }
                if let height = Dict["height"] as? String{
                    
                    self._height = height
                }
                if let defense = Dict["defense"] as? Int{
                    
                    self._defense = "\(defense)"
                }
                if let attack = Dict["attack"] as? Int{
                    self._baseAttack = "\(attack)"
                }
             
                
                print(self._weight)
                print(self._height)
                print(self._defense)
                print(self._baseAttack)
                
                
            }
            completed()
        }
        
        
        
    }
}
