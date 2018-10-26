//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Yvette Zhukovsky on 10/26/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//


import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {
    
    var pokemonController: PokedexController?
    var poke: Pokemon? {
        return pokemonController?.pokemon
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchB.delegate = self
        updateViews()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchEntry = searchB.text else {return}
        pokemonController?.fetchPokemon(name: searchEntry , completion: {(error) in
            if let error = error {
                NSLog("error getting pokemon:\(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.updateViews()
            }
        })
    }
    
    func updateViews() {
        if let pokemon = poke {
            self.title = pokemon.name
            idLabel?.text = "ID: \(String(pokemon.id))"
            typeLabel?.text = "Type: \(poke?.types.map({$0.type.name}).joined(separator:" , ") ?? "")"
            abilitiesLabel?.text = "Abilities: \(poke?.abilities.map({$0.ability.name}).joined(separator:" , ") ?? "")"
            saveButton.setTitle("Save Pokemon", for: .normal)
            
            if let spriteURL = pokemon.sprites.filter({$0.value != nil}).randomElement()?.value {
                
                ImageLoader.fetchImage(from: URL(string:spriteURL)){ image in
                    
                    guard let image = image else {return }
                    DispatchQueue.main.async {
                        
                        self.pokeImage.image = image
                    }
                }
            }
            
            
        } else {
            self.title = "Pokemon Search"
            idLabel?.text = ""
            typeLabel?.text = ""
            abilitiesLabel?.text = ""
            saveButton.setTitle("", for: .normal)
            
            
            
        }
        
        
    }
    
    
    
    
    @IBOutlet weak var searchB: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    @IBAction func savePokemon(_ sender: Any) {
        
        guard let p = poke else {return}
        
        
        pokemonController?.savePokemons(pokemon: p)
        
        
    }
    
    
    @IBOutlet weak var pokeImage: UIImageView!
    
    
    @IBOutlet weak var saveButton: UIButton!
}

    
    
    
    
    
    

