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
    
    //create an array of pokemon
    var pokemon = [Pokemon]() //initialized array (()) of type Pokemon
    
    
    //viewDidLoad calls right when the app loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        parsePokemnonCSV()
        
        
        //How to create an object for a object pokemon
        //let charmender = Pokemon(name: "Charmender", pokedexId: 4)
    }
    
    func parsePokemnonCSV() {
        
        //create path for our pokemon csv file
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            //use the CSVParser to pull out the rows.
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            //pull out data we want
            
            //go through each row and get the pokeId and name of each one
            for row in rows {
                let pokeId = Int(row["id"]!)! //force unwrap
                let name = row["identifier"]!
                
                //create pokemon object named poke
                let poke = Pokemon(name: name, pokedexId: pokeId)
                //append and attach each poke to the pokemon array created above
                
                pokemon.append(poke) //append and pass poke in
                
                
                
    
            }
            
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    //Load only objects related. Dequeues the cells and sets them up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke = pokemon[indexPath.row]
            cell.configureCell(pokemon: poke)
            
            
            
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
        return pokemon.count //as many pokemon as in CSV file
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

