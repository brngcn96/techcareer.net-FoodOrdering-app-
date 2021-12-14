//
//  SepetVC.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 13.12.2021.
//

import UIKit

class SepetVC: UIViewController {


    
    @IBOutlet weak var cartTableView: UITableView!
    var sepetListe = [Yemek]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  


}

extension SepetVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetListe.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yemek = sepetListe[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = sepetListe[indexPath.row]
        let hucre = tableView.dequeueReusableCell(withIdentifier: "cartcell", for: indexPath) as! CartTableViewCell
        
        hucre.foodPriceLabel.text = "\(yemek.yemek_fiyat!) ₺"
        hucre.foodNameLabel.text = yemek.yemek_adi!
        //hucre.i.text = yemek.yemek_adi
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
           // DispatchQueue.global().async {
               // let data = try? Data(contentsOf: url)
                DispatchQueue.main.async{
                   // self.imageView.image = UIImage(data: data!)
                    hucre.cartImageView.kf.setImage(with:url)
                    
                }
           
        }
          
        
        return hucre
    }
    
 
    
}
