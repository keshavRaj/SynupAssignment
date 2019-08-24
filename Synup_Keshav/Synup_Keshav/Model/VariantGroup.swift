//
//  VariantGroup.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 24/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import Foundation

class VariantGroup {
    let groupId: String
    let name: String
    let variations: [Variation]
    
    private enum Keys: String {
        case group_id, name, variations
    }
    
    init?(dict: [String: Any]) {
       // let ids = dict[Keys.group_id.rawValue] as! String
        guard let id = dict[Keys.group_id.rawValue] as? String,
            let name = dict[Keys.name.rawValue] as? String,
            let variations = dict[Keys.variations.rawValue] as? [[String: Any]] else {
                 debugPrint("Could not Initialize VariantGroup Object with dictionary \(dict)")
                return nil
        }
        self.groupId = id
        self.name = name
        var variationList = [Variation]()
        for aDict in variations {
            if let variation = Variation(dict: aDict) {
                variationList.append(variation)
            }
        }
        self.variations = variationList
    }
    
}
