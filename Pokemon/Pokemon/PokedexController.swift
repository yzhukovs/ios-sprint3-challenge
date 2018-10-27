//
//  PokedexController.swift
//  Pokemon
//
//  Created by Yvette Zhukovsky on 10/26/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

class PokedexController {
    let baseURL = URL(string:"https://pokeapi.co/api/v2/")
    var pokemons:[Pokemon]=[]
    
    func fetchPokemon(name: String, completion: @escaping (Pokemon?, Error?) -> Void){
        guard let url = baseURL?
            .appendingPathComponent("pokemon")
            .appendingPathComponent(name.lowercased())
            .appendingPathComponent("") else {return}
        
        Fetcher.GET(url:url, completion:completion)
    }
    
    func savePokemons(pokemon:Pokemon){
        pokemons.append(pokemon)
    }
    
    
    func deletePokemon(at: Int) {
        pokemons.remove(at: at)
    }
}


