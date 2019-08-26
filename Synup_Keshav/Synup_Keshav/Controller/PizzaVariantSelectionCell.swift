//
//  PizzaVariantSelectionCell.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 24/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import UIKit

class PizzaVariantSelectionCell: UITableViewCell {

   
    @IBOutlet weak var selectionView: SelectionView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var variantNameLabel: UILabel!
    @IBOutlet weak var inStockLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
