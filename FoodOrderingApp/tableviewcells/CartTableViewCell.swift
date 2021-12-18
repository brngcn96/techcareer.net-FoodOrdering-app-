//
//  CartTableViewCell.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 14.12.2021.
//

import UIKit

protocol YourCellDelegate {
    func didPressTrashButton(_ tag: Int)
}

class CartTableViewCell: UITableViewCell {
    
    var cellDelegate: YourCellDelegate?
    
    @IBOutlet weak var cartImageView: UIImageView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    @IBOutlet weak var trashbutton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func trashButtonClicked(_ sender: UIButton) {
        cellDelegate?.didPressTrashButton(sender.tag)
       
    }

}
