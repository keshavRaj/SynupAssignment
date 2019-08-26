//
//  Exclusion.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 26/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import Foundation

struct Exclusion {
    let sourceGroupId: String
    let sourceVariationId: String
    let affectedGroupId: String
    let affectedVariationId: String
    
    private enum Keys: String {
        case group_id, variation_id
    }
    
    init?(exclusion: [[String: Any]]) {
        guard exclusion.count == 2,
            let sourceGroup = exclusion[0][Keys.group_id.rawValue] as? String,
            let sourceVariation = exclusion[0][Keys.variation_id.rawValue] as? String,
            let affectedGroup = exclusion[1][Keys.group_id.rawValue] as? String,
            let affectedVariation = exclusion[1][Keys.variation_id.rawValue] as? String else {
                debugPrint("Could not create exclusion list from given list")
                return nil
        }
        self.sourceGroupId = sourceGroup
        self.sourceVariationId = sourceVariation
        self.affectedGroupId = affectedGroup
        self.affectedVariationId = affectedVariation
    }
}
