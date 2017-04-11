//
//  DetailViewController.swift
//  PokedexApp
//
//  Created by John Gallaugher on 4/10/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    var name: String?
    var url: String?
    var pokeDetails = PokeDetails()
    
    override func viewDidLoad() {
        print("Name: \(name!) Url: \(url!)")
        super.viewDidLoad()
        pokeDetails.getPokeDetails(url: url!) {
            self.updateUserInterface()
        }
    }
    
    func updateUserInterface() {
        nameLabel.text = pokeDetails.name
        weightLabel.text = String(pokeDetails.weight)
        heightLabel.text = String(pokeDetails.height)
        let imageURL = URL(string: pokeDetails.imageURL)
        let data = try? Data(contentsOf: imageURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        pokemonImage.image = UIImage(data: data!)
    }

}
