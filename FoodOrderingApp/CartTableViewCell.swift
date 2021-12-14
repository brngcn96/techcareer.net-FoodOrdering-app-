//
//  CartTableViewCell.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 14.12.2021.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cartImageView: UIImageView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    @IBOutlet weak var foodPriceLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
