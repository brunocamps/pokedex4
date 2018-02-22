//
//  ViewController.swift
//  Pokedex4
//
//  Created by Bruno Campos on 2/22/18.
//  Copyright © 2018 Bruno Campos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        
        //How to create an object for a object pokemon
        //let charmender = Pokemon(name: "Charmender", pokedexId: 4)
    }
    
    //Load only objects related. Dequeues the cells and sets them up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon = Pokemon(name: "Pokemon", pokedexId: indexPath.row) //pokemon object
            cell.configureCell(pokemon: pokemon)
            
            
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    //method taht when you select an object it does something. Tap in a cell and the code below will be executed
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //Number of items in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    //Number of sections in the collection view
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Define the size of the cells
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105) //as set in the storyboard
    }
    
    


}

