//
//  SelectPizzaVariationVC.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 24/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import UIKit

class SelectPizzaVariationVC: UIViewController {

    let model = PizzaVariationVM.shared
   
    override func viewDidLoad() {
        super.viewDidLoad()
        model.fetchPizzaVariations()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
