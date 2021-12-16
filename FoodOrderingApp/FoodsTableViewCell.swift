//
//  FoodsTableViewCell.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 8.12.2021.
//

import UIKit

class FoodsTableViewCell:UITableViewCell {
    
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        if likeButton.tag == 0 // Boş
        {
            likeButton.setImage(UIImage(named: "LikeFilled"), for: .normal)
            likeButton.tag = 1
        }
        else  // Dolu
        {
            likeButton.setImage(UIImage(named: "LikeBorder"), for: .normal)
            likeButton.tag = 0
        }
        
        
    }
    
}
