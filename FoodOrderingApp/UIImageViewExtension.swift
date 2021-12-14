//
//  UIImageViewExtension.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 13.12.2021.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    
    func setImage(_ imageUrl:String, placeholder:String){
        self.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: placeholder))
        
    }
}
