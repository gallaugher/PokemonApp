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
    
    var pokeArray = [PokeData]()
    
    func getPokemon(completed: @escaping () -> () ) {
        let pokeURL = "https://pokeapi.co/api/v2/pokemon/"
        Alamofire.request(pokeURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                for index in 0...json["results"].count-1 {
                    let name = json["results"][index]["name"].stringValue
                    let url = json["results"][index]["url"].stringValue
                    print(name, url)
                    self.pokeArray.append(PokeData(name: name, url: url))
                }
                print(self.pokeArray)
                
            case .failure(let error):
                print("Oh no! There was an error accessing the JSON! Error code: \(error)")
            }
            completed()
        }
    }
}
