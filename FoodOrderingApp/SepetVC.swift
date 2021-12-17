//
//  SepetVC.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 13.12.2021.
//

import UIKit

class SepetVC: UIViewController,YourCellDelegate {

    

    var sepetPresenterNesnesi:ViewToPresenterSepetProtocol?
    
    @IBOutlet weak var sepetBadgeItem: UITabBarItem!
    @IBOutlet weak var toplamTutarLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    var sepetListe = [SepetEleman]()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        SepetRouter.createModule(ref: self)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sepetPresenterNesnesi?.sepettekileriYukle()
    }
    
    func didPressButton(_ tag: Int) {
        
            print("tıklandı \(tag)")

            
            let sepet_yemek = self.sepetListe[tag]
            
            let alert = UIAlertController(title: "Sepetten Kaldır", message: "\(sepet_yemek.yemek_adi!) sepetinizden kaldırılsın mı?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){ action in
                
            }
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Kaldır", style: .destructive){ action in
                self.sepetPresenterNesnesi?.sil(sepet_yemek_id: sepet_yemek.sepet_yemek_id!)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        
    }
    


        

}

extension SepetVC : PresenterToViewSepetProtocol {
    func vieweVeriGonder(sepetListesi: Array<SepetEleman>) {
        self.sepetListe = sepetListesi
        
        var total = 0
        sepetListe.forEach { sepet_yemek in

            total = total + (Int)(sepet_yemek.yemek_siparis_adet!)! * (Int)(sepet_yemek.yemek_fiyat!)!
        }
        DispatchQueue.main.async {
            
            self.toplamTutarLabel.text = "\(total)₺"
            self.cartTableView.reloadData()
            self.sepetBadgeItem.badgeValue = "\(sepetListesi.count)"
        }
    }
}

extension SepetVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetListe.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yemek = sepetListe[indexPath.row]
        //performSegue(withIdentifier: "toDetay", sender: yemek)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sepet_yemek = sepetListe[indexPath.row]
        let hucre = tableView.dequeueReusableCell(withIdentifier: "cartcell", for: indexPath) as! CartTableViewCell
        
        hucre.cellDelegate = self
        hucre.trashbutton.tag = indexPath.row
        
        
        print(sepet_yemek.yemek_adi!)
        hucre.foodPriceLabel.text = "\(sepet_yemek.yemek_fiyat!) ₺  X \(sepet_yemek.yemek_siparis_adet!) "
        hucre.foodNameLabel.text = sepet_yemek.yemek_adi!
        

        
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
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Kaldır"){ (contextualAction,view,bool) in
            
            let sepet_yemek = self.sepetListe[indexPath.row]
            
            let alert = UIAlertController(title: "Sepetten Kaldır", message: "\(sepet_yemek.yemek_adi!) sepetinizden kaldırılsın mı?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){ action in
                
            }
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Kaldır", style: .destructive){ action in
                self.sepetPresenterNesnesi?.sil(sepet_yemek_id: sepet_yemek.sepet_yemek_id!)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
    
    
 
    
}
