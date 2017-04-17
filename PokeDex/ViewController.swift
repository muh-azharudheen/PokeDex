//
//  ViewController.swift
//  PokeDex
//
//  Created by Mac on 4/15/17.
//  Copyright © 2017 xerox101. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UISearchBarDelegate,UISearchControllerDelegate,UITextFieldDelegate{
    
    
    @IBOutlet weak var pokeCollectionView:UICollectionView!
    @IBOutlet weak var collectionSearchBar:UISearchBar!
    
    
    
    var pokemon = [Pokemon]()
    var inSearchmode:Bool!
    var filteredPokemon = [Pokemon]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.collectionSearchBar.delegate = self
        
        parsePokemonCSV()
        
        inSearchmode = false
        collectionSearchBar.returnKeyType = .done
     //   collectionSearchBar.showsCancelButton = false
       
      
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
 //   searchbarclear
    

    
    func parsePokemonCSV(){
        
       let path = Bundle.main.path(forResource: "pokemon", ofType:"csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows{
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
                
                
            }
            
            
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            
            if inSearchmode{
                
                let poke = filteredPokemon[indexPath.row]
                cell.configCell(poke)
                
            } else
            {
                
                let poke = pokemon[indexPath.row]
                cell.configCell(poke)
                
            }
            
            return cell
           
        } else {
            return UICollectionViewCell()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if inSearchmode{
            
            return filteredPokemon.count
            
        }
        return pokemon.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
      
        var poke:Pokemon!
        
        if inSearchmode{
            
             poke = filteredPokemon[indexPath.row]
            
        } else
        {
            poke = pokemon[indexPath.row]
        }
        
        
        performSegue(withIdentifier: "PokeDetailVc", sender: poke)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 80, height: 100)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       
        
        if collectionSearchBar.text == nil || collectionSearchBar.text == ""{
            
            inSearchmode = false
            pokeCollectionView.reloadData()
            
            view.endEditing(true)
            
            }
        else  if
            searchText.characters.count == 0{
           view.endEditing(true)
        }
        else
        {
            inSearchmode = true
            
            let lower = collectionSearchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil })
            pokeCollectionView.reloadData()
            

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokeDetailVc"{
            
            if let detailVC = segue.destination as? PokeDetailVC{
                
                if let poke = sender as? Pokemon{
                    
                    
                    detailVC.detailedPokemon = poke
                }
            }
            
    }
}

}
