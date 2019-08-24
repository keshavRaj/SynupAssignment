//
//  SynupEndPoint.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 24/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import Foundation

// MARK: Protocol to have base and path of network calls
protocol SynupEndPoint {
    var base: String { get }
    var path: String { get }
}

extension SynupEndPoint {
    
    var request: String {
        return base + path
    }
}

// MARK: Enum to handle Synup network calls
enum PizzaFeed {
    case getPizzaVariants
}

extension PizzaFeed: SynupEndPoint {
    
    var base: String {
        return "https://api.myjson.com/"
    }
    
    var path: String {
        switch self {
        case .getPizzaVariants: return "bins/19u0sf"
        }
    }
}


