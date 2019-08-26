//
//  Variation.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 24/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import Foundation

struct Variation {
    let id: String
    let inStock: Int
    let name: String
    let price: Int
    
    private enum Keys: String {
        case id, inStock, name, price
    }
    
    init?(dict: [String: Any]) {
        guard let id = dict[Keys.id.rawValue] as? String,
            let inStock = dict[Keys.inStock.rawValue] as? Int,
            let name = dict[Keys.name.rawValue] as? String,
            let price = dict[Keys.price.rawValue] as? Int else {
                debugPrint("Could not Initialize Variation Object with dictionary \(dict)")
                return nil
        }
        self.id = id
        self.inStock = inStock
        self.name = name
        self.price = price
    }
}
