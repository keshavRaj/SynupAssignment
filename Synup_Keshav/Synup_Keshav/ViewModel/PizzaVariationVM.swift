//
//  PizzaVariationVM.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 24/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import Foundation

class PizzaVariationVM {
    static let shared = PizzaVariationVM()
    private let VARIANTS = "variants"
    private let EXCLUDELIST = "exclude_list"
    private let VARIANTGROUPS = "variant_groups"
    private var _variants = [VariantGroup]()
    private var _exclusions = [Exclusion]()
    public var variants = [VariantGroup]()
    
    private init() { }
    
    func fetchPizzaVariations(completion: @escaping(Bool) -> Void ) {
        NetworkManager.shared.JSONGetRequest(endPoint: PizzaFeed.getPizzaVariants) {
            [weak self] result in
            guard let weakSelf = self else {
                debugPrint("Self has been dealocated....Returning....")
                completion(false)
                return
            }
            switch result {
            case .success(let jsondict):
                guard let variantsDict = jsondict[weakSelf.VARIANTS] as? [String: Any],
                    let variantGroups = variantsDict[weakSelf.VARIANTGROUPS] as? [[String: Any]] else {
                        debugPrint("Json is not in the agreed format from the server")
                        completion(false)
                        return
                }
                weakSelf._variants = [] //Clear it.
                weakSelf._exclusions = [] //clear it
                for aGroup in variantGroups {
                    if let group = VariantGroup(dict: aGroup) {
                        weakSelf._variants.append(group)
                    }
                }
                
                if let exclusions = variantsDict[weakSelf.EXCLUDELIST] as? [[[String: Any]]] {
                    for anExclusion in exclusions {
                        if let exclusion = Exclusion(exclusion: anExclusion) {
                            weakSelf._exclusions.append(exclusion)
                        }
                    }
                }
                weakSelf.select(0, in: 0)
                completion(true)
            case .error (_):
                print("Handle the error")
                completion(false)
            }
        }
    }
    
    func select(_ variation: Int, in group: Int) {
        var tempVariants = _variants
        for anExclusion in _exclusions {
            if anExclusion.sourceGroupId == _variants[group].groupId ,
                anExclusion.sourceVariationId == _variants[group].variations[variation].id {
                for (variantIndex, variant) in _variants.enumerated() {
                    if variant.groupId == anExclusion.affectedGroupId {
                        for (variationIndex, aVariation) in variant.variations.enumerated() {
                            if aVariation.id == anExclusion.affectedVariationId {
                                tempVariants[variantIndex].variations.remove(at: variationIndex)
                            }
                        }
                    }
                }
            }
        }
        variants = tempVariants
    }
    
}
