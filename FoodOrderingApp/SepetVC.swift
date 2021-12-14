//
//  SepetVC.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 13.12.2021.
//

import UIKit

class SepetVC: UIViewController {

    var sepetPresenterNesnesi:ViewToPresenterSepetProtocol?
    
    @IBOutlet weak var cartTableView: UITableView!
    var sepetListe = [SepetEleman]()
    override func viewDidLoad() {
        super.viewDidLoad()

        SepetRouter.createModule(ref: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sepetPresenterNesnesi?.sepettekileriYukle()
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            let kisi = sender as? Se
            let gidilecekVC = segue.destination as! KisiDetayVC
            gidilecekVC.kisi = kisi
        }
    }
   */

}

extension SepetVC : PresenterToViewSepetProtocol {
    func vieweVeriGonder(sepetListesi: Array<SepetEleman>) {
        self.sepetListe = sepetListesi
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
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
        let sepet_yemek = sepetListe[indexPath.row]
        let hucre = tableView.dequeueReusableCell(withIdentifier: "cartcell", for: indexPath) as! CartTableViewCell
        
        hucre.foodPriceLabel.text = "\(sepet_yemek.yemek_fiyat!) ₺"
        hucre.foodNameLabel.text = sepet_yemek.yemek_adi!
        //hucre.i.text = yemek.yemek_adi
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(sepet_yemek.yemek_resim_adi!)"){
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
