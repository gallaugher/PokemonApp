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
    @IBOutlet weak var noImage: UILabel!
    
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
        nameLabel.text = pokeDetails.name.capitalized
        weightLabel.text = String(pokeDetails.weight)
        heightLabel.text = String(pokeDetails.height)
        
        // I also added a check to see if there was a valid URL for
        // the image URL.  The try below has been updated to catch and report
        // an error.  Also: the line below will show or hide the noImage line
        // depending on if there is or is not am image.
        noImage.isHidden = (pokeDetails.imageURL == "" ? false : true )
        if let imageURL = URL(string: pokeDetails.imageURL) {
            do {
                let data = try Data(contentsOf: imageURL) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                pokemonImage.image = UIImage(data: data)
            }
            catch {
                print("Data for: \(name!) isn't a valid URL")
            }
        } else {
            print("No image available for: \(name!)")
        }
    }
}
