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
    private var variants = [VariantGroup]()
    
    private init() { }
    
    func fetchPizzaVariations() {
        NetworkManager.shared.JSONGetRequest(endPoint: PizzaFeed.getPizzaVariants) {
            [weak self] result in
            guard let weakSelf = self else {
                debugPrint("Self has been dealocated....Returning....")
                return
            }
            switch result {
            case .success(let jsondict):
                guard let variantsDict = jsondict[weakSelf.VARIANTS] as? [String: Any],
                    let variantGroups = variantsDict[weakSelf.VARIANTGROUPS] as? [[String: Any]] else {
                        debugPrint("Json is not in the agreed format from the server")
                        return
                }
                weakSelf.variants = [] //Clear it.
                for aGroup in variantGroups {
                    if let group = VariantGroup(dict: aGroup) {
                        weakSelf.variants.append(group)
                    }
                }
                
            case .error (_):
                print("Handle the error")
            }
        }
    }
}
