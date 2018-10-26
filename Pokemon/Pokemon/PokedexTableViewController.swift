//
//  PokedexTableViewController.swift
//  Pokemon
//
//  Created by Yvette Zhukovsky on 10/26/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    let pokemonController = PokedexController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemonController.pokemons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? ImageCellTableViewCell {
            let pokemon = pokemonController.pokemons[indexPath.row]
            cell.poke = pokemon
        }
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let poke = pokemonController.pokemons[indexPath.row]
            pokemonController.deletePokemon(id: poke.id)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearch" {
            guard let destination = segue.destination as? DetailViewController  else {return}
            destination.pokemonController = pokemonController
            
            
        }
        
    }
    
}
