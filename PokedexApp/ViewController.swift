//
//  ViewController.swift
//  PokedexApp
//
//  Created by John Gallaugher on 4/10/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
//    var pokeArray = ["bulbasaur",
//                     "pikachu",
//                     "snorlax",
//                     "squirtle"]
    
    var pokemon = Pokemon()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        pokemon.getPokemon {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        let selectedIndex = tableView.indexPathForSelectedRow!
        destination.name = pokemon.pokeArray[selectedIndex.row].name
        destination.url = pokemon.pokeArray[selectedIndex.row].url
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.pokeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = pokemon.pokeArray[indexPath.row].name
        return cell
    }
}
