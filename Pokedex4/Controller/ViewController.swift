//
//  ViewController.swift
//  Pokedex4
//
//  Created by Bruno Campos on 2/22/18.
//  Copyright © 2018 Bruno Campos. All rights reserved.
//

import UIKit
import AVFoundation //audio

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    //create an array of pokemon
    var pokemon = [Pokemon]() //initialized array (()) of type Pokemon
    var filteredPokemon = [Pokemon]()
    //music player variable
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    
    //viewDidLoad calls right when the app loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemnonCSV()
        initAudio()
        
        
        //How to create an object for a object pokemon
        //let charmender = Pokemon(name: "Charmender", pokedexId: 4)
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 //it will loop continuously
            musicPlayer.play()
        } catch let err as NSError{
            print(err.debugDescription)
        }
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
            
            let poke: Pokemon!
            
            if inSearchMode{
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
         else {
            poke = pokemon[indexPath.row]
            cell.configureCell(pokemon: poke)
                
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    //method taht when you select an object it does something. Tap in a cell and the code below will be executed
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        //perform the segue
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    //Number of items in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
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
    
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //any time we make a key stroke in the search bar, this code will be called
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            //filteredPokemon list is going to be equal to the original pokemon list, but now it's filtered
            //$0 is a placeholder for any or all of the objects in the original pokemon array
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData() //repopulate the collection view with new data
        }
        
    }
    
    
    //prepare for the segue sending anyobject.
    //poke is the sender of class Pokemon
    //then we use detailsVC as destination view controller, created on ViewController
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    


}

