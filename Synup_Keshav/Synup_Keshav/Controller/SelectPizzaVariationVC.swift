//
//  SelectPizzaVariationVC.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 24/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import UIKit

class SelectPizzaVariationVC: UIViewController {
    
    @IBOutlet weak var orderButton: UIBarButtonItem!
    @IBOutlet weak var variantTableView: UITableView!
    let model = PizzaVariationVM.shared
    private var selections = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        fetchPizzaVariationFromServer()
        orderButton.isEnabled = false
    }
    
    private func initialSetup() {
        
        variantTableView.delegate = self
        variantTableView.dataSource = self
        variantTableView.tableFooterView = UIView()
    }
    
    private func fetchPizzaVariationFromServer() {
        model.fetchPizzaVariations {
            [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.uploadTableView()
                    self?.orderButton.isEnabled = true
                }
            } else {
                debugPrint("Some error occure...Handle it")
            }
        }
    }
    
    private func uploadTableView() {
        DispatchQueue.main.async {
            [unowned self] in
            self.selections.removeAll()
            for _ in self.model.variants {
                self.selections.append(0)
            }
            self.variantTableView.reloadData()
        }
    }
    
    @IBAction func orderButtonClicked(_ sender: Any) {
        var bill = 0
        for (index, aVariant) in model.variants.enumerated() {
            bill += aVariant.variations[selections[index]].price
        }
        let alertViewController = UIAlertController(title: "Successfully ordered", message: "Your total bill is \(bill)", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    
}


extension SelectPizzaVariationVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.variants.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.variants[section].variations.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.variants[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PizzaVariantSelectionCell.self)) as! PizzaVariantSelectionCell
        let variation = model.variants[indexPath.section].variations[indexPath.row]
        cell.priceLabel.text = "\(variation.price)"
        cell.variantNameLabel.text = variation.name
        cell.inStockLabel.text = "In Stock: \(variation.inStock)"
        cell.selectionView.isSelected = selections[indexPath.section] == indexPath.row ? 1 : 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.select(indexPath.row, in: indexPath.section)
        if indexPath.row >= model.variants[indexPath.section].variations.count {
            selections[indexPath.section] = 0
        } else {
            selections[indexPath.section] = indexPath.row
        }
        tableView.reloadData()
    }
    
}
