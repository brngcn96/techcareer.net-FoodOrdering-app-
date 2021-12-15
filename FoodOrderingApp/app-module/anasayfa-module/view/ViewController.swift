//
//  ViewController.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 7.12.2021.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {

    var yemeklerListe = [Yemek]()
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    
    @IBOutlet weak var yemeklerTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let appereance = UINavigationBarAppearance()
        appereance.titleTextAttributes = [NSAttributedString.Key.font:UIFont(name: "Courgette-Regular", size: 22)!]
        
        navigationController?.navigationBar.standardAppearance = appereance
        navigationController?.navigationBar.compactAppearance = appereance
        navigationController?.navigationBar.scrollEdgeAppearance = appereance
        
        yemeklerTableView.delegate = self
        yemeklerTableView.dataSource = self
        
        AnasayfaRouter.createModule(ref: self)
        sepetTest()
        // Do any additional setup after loading the view.
    }
    
    //Anasayfaya geri döndüğümüzde çalışır
    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.yemekleriYukle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            let yemek = sender as? Yemek
            let gidilecekVC = segue.destination as! YemekDetayVC
            gidilecekVC.yemek = yemek
        }
        if segue.identifier == "toSepet" {
            let gidilecekVC = segue.destination as! SepetVC
            
        }
    }
    
    
    @IBAction func buttonChartAction(_ sender: Any) {
        performSegue(withIdentifier: "toSepet", sender: nil)
        
        
    }
    

    
    func sepetTest(){
        let params:Parameters=["kullanici_adi":"baran"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).responseJSON{ response in
            
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: [])
                        as? [String:Any] {
                        print(json)
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
            
            
        }
    }


}


extension ViewController : PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemeklerListesi: Array<Yemek>) {
        self.yemeklerListe = yemeklerListesi
        DispatchQueue.main.async {
            self.yemeklerTableView.reloadData()
        }
    }
}



extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemeklerListe.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yemek = yemeklerListe[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = yemeklerListe[indexPath.row]
        let hucre = tableView.dequeueReusableCell(withIdentifier: "foodcell", for: indexPath) as! FoodsTableViewCell
        
        hucre.foodPriceLabel.text = "\(yemek.yemek_fiyat!) ₺"
        hucre.foodNameLabel.text = yemek.yemek_adi!
        //hucre.i.text = yemek.yemek_adi
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
           // DispatchQueue.global().async {
               // let data = try? Data(contentsOf: url)
                DispatchQueue.main.async{
                   // self.imageView.image = UIImage(data: data!)
                    hucre.foodImageView.kf.setImage(with:url)
                    
                }
           
        }
          
        
        return hucre
    }
    
 
    
}

