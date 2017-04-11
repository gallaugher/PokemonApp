//
//  Pokemon.swift
//  PokedexApp
//
//  Created by John Gallaugher on 4/10/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Pokemon {
    
    struct PokeData {
        var name = ""
        var url = ""
    }
    
    var numberOfPokemon = 0
    var pokeArray = [PokeData]()
    
    // ?limit=20
    
    func getPokemon(completed: @escaping () -> () ) {
        let pokeURL = "https://pokeapi.co/api/v2/pokemon/"
        Alamofire.request(pokeURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.numberOfPokemon = json["count"].intValue
            case .failure(let error):
                print("Oh no! There was an error accessing the JSON! Error code: \(error)")
            }
             completed()
        }
    }
    
    func getAllPokemon(completed: @escaping () -> () ) {
        let fullURL = "https://pokeapi.co/api/v2/pokemon/?limit=\(numberOfPokemon)"
        Alamofire.request(fullURL).responseJSON { response in
            print("FULL URL = " + fullURL)
            switch response.result {
            case .success(let value):
                print("VALUE = \(value)")
                let json = JSON(value)
                for index in 0...json["results"].count-1 {
                    let name = json["results"][index]["name"].stringValue
                    let url = json["results"][index]["url"].stringValue
                    self.pokeArray.append(PokeData(name: name.capitalized, url: url))
                }
                for i in 0..<self.pokeArray.count {
                    print(self.pokeArray[i].name)
                }
            case .failure(let error):
                print("Oh no! There was an error accessing the JSON! Error code: \(error)")
            }
            completed()
        }
    }
}
