//
//  PokemonDetailVC.swift
//  Pokedex4
//
//  Created by Bruno Campos on 3/5/18.
//  Copyright © 2018 Bruno Campos. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
        
    }

    

   

}
