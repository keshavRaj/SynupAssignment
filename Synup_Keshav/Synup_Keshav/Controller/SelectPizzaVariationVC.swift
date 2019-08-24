//
//  SelectPizzaVariationVC.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 24/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import UIKit

class SelectPizzaVariationVC: UIViewController {

    @IBOutlet weak var variantTableView: UITableView!
    let model = PizzaVariationVM.shared
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        model.fetchPizzaVariations()
        variantTableView.delegate = self
        variantTableView.dataSource = self
    }
}

extension SelectPizzaVariationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PizzaVariantSelectionCell.self)) as! PizzaVariantSelectionCell
        return cell
    }
    
}
