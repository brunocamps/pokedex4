//
//  Pokemon.swift
//  Pokedex4
//
//  Created by Bruno Campos on 2/22/18.
//  Copyright © 2018 Bruno Campos. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    //getters
    var name: String{
        
        return _name
    }
    
    var pokedexId: Int{
        
        return _pokedexId
    }
    
    //initialize each pokemon object
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
    }
    
    
}
