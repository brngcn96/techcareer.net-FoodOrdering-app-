//
//  ViewController.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 12.12.2021.
//

import UIKit
import Kingfisher
import Alamofire

class YemekDetayVC: UIViewController {

    
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var sepetAdetLabel: UILabel!
    var yemek:Yemek?
    var adet = 1
    
    var yemekDetayPresenterNesnesi:ViewToPresenterYemekDetayProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = yemek?.yemek_adi
        
        sepetAdetLabel.text = "1"
        if let y = yemek{
            foodNameLabel.text = y.yemek_adi
            foodPriceLabel.text = y.yemek_fiyat
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)"){
               // DispatchQueue.global().async {
                   // let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async{
                       // self.imageView.image = UIImage(data: data!)
                        self.foodImageView.kf.setImage(with:url)
  
                    }
            }
         
        }
        
  
        
        // Do any additional setup after loading the view.
        
        YemekDetayRouter.createModule(ref: self)
    }
    
    

    @IBAction func sepetStepper(_ sender: UIStepper) {
        
        adet = Int(sender.value)
        sepetAdetLabel.text = "\(Int(sender.value))"
        
    }
    
    
    @IBAction func buttonSepeteEkle(_ sender: Any) {
        
        if let y = yemek{
            yemekDetayPresenterNesnesi?.yemekEkle(yemek_adi: y.yemek_adi!, yemek_resim_adi: y.yemek_resim_adi!, yemek_fiyat: Int(y.yemek_fiyat!)!, yemek_siparis_adet: adet, kullanici_adi: "baran")
        }

    }


    
    
}
