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
    private var _description:String!
    private var _type :String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _baseAttack:String!
    private var _nextEvolutionText:String!
    private var _nextEvolutionName:String!
    private var _nextEvolutionId:String!
    private var _nextEvolutionLevel:String!
    private var _pokemonURL:String!
    
    
    
    var nextEvolutionName:String{
        
        if _nextEvolutionName ==  nil{
            
            _nextEvolutionName = ""
            
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionText:String{
        
        if _nextEvolutionText == nil {
            
            _nextEvolutionText = ""
        }
        
        return _nextEvolutionText
    }
    
    
    var nextEvolutionId:String{
        
        if _nextEvolutionId == nil{
            
            _nextEvolutionId = ""
            
        }
        return _nextEvolutionId
        
    }
    
    var nextEvolutionLevel:String{
        
        if _nextEvolutionLevel == nil {
            
            _nextEvolutionLevel = ""
            
        }
        
        return _nextEvolutionLevel
    }
    
    
    
    
    var type:String{
        
        if _type == nil {
            
            _type = ""
            
        }
        return _type
    }
    
    
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
    var description:String{
        
        if _description == nil{
            
            _description = ""
        }
        return _description
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
                
                
                if let types = Dict["types"] as? [Dictionary<String,String>], types.count > 0{
                    
                    
                    let name = types[0] ["name"]
                    self._type = name?.capitalized
                    
                    if types.count>1{
                        
                        for x in 1..<types.count{
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += " /\(name.capitalized)"
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    
                    
                } else {
                    
                    self._type = ""
                    
                }
                
                if let descArr = Dict["descriptions"] as? [Dictionary<String,AnyObject>] , descArr.count > 0 {
                    
                    
                    if let resourceURL = descArr[0] ["resource_uri"]{
                        
                        let url = "\(BASE_URL)\(resourceURL)"
                        
                        
                        Alamofire.request(url).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String,AnyObject>{
                                
                                
                                if let description = descDict["description"] as? String{
                                    
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "PokeMon")
                                    
                                    
                                    self._description = newDescription
                                    
                                    
                                    
                                }
                                
                            }

                            
                            completed()
                            
                            
                        })
                        
                    } else {
                        
                        self._description = ""
                        
                    }
                }
                    
                if let evolutions = Dict["evolutions"] as? [Dictionary<String,AnyObject>] , evolutions.count > 0{
                    
                    if let nextEvo = evolutions[0]["to"] as? String{
                        
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                
                                let nextEvoID = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoID
                                
                                
                                if let levelExist = evolutions[0]["level"]{
                                    
                                    
                                    if let level = levelExist as? Int{
                                        
                                        
                                        self._nextEvolutionLevel = "\(level)"
                                    } else {
                                        
                                        self._nextEvolutionLevel = ""
                                        
                                    }
                                }
                                
                                
                            }

                        }
                        
                        
                        
                        
                    }
                    
    
                    
                    
                    
                }
            
                
            }
            completed()
        }
        
        
        
    }
}
