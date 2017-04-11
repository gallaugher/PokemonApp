//
//  PokeDetails.swift
//  PokedexApp
//
//  Created by John Gallaugher on 4/10/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PokeDetails {
    var name = ""
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    
    func getPokeDetails(url: String, completed: @escaping () -> () ) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                self.name = json["name"].stringValue
                self.height = json["height"].doubleValue
                self.weight = json["weight"].doubleValue
                self.imageURL = json["sprites"]["front_default"].stringValue
                
            case .failure(let error):
                print("Oh no! There was an error accessing the JSON! Error code: \(error)")
            }
            completed()
        }
    }
}
