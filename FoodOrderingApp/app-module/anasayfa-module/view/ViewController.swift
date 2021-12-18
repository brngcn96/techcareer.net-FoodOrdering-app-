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

    
    var filteredYemeklerListe = [Yemek]()
    
    var yemeklerListe = [Yemek]()
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    
    @IBOutlet weak var yemeklerTableView: UITableView!
    
    @IBOutlet weak var yemeklerSearchBar: UISearchBar!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let appereance = UINavigationBarAppearance()
        appereance.titleTextAttributes = [NSAttributedString.Key.font:UIFont(name: "Courier-Bold", size: 22)]
        
        navigationController?.navigationBar.standardAppearance = appereance
        navigationController?.navigationBar.compactAppearance = appereance
        navigationController?.navigationBar.standardAppearance = appereance
         
         
        
        yemeklerSearchBar.delegate = self
        
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
    
    
    @IBAction func buttonAddCartAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: yemeklerTableView)
        guard let indexPath = yemeklerTableView.indexPathForRow(at: point)
        else{return}
        
        let yemek = filteredYemeklerListe[indexPath.row]
        anasayfaPresenterNesnesi?.yemekEkle(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: (Int)(yemek.yemek_fiyat!)!, yemek_siparis_adet: 1, kullanici_adi: "baran")
        
        
        let alert = UIAlertController(title: "Sepete Ekle", message: "\(yemek.yemek_adi!) sepetinize eklendi!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Alışverişe Devam Et", style: .default){ action in
            
        }
        alert.addAction(OKAction)
        let sepeteGitAction = UIAlertAction(title: "Sepete Git", style: .default){ action in
            
            self.performSegue(withIdentifier: "toSepet", sender: nil)
            
        }
        alert.addAction(sepeteGitAction)
        
        self.present(alert, animated: true)
        
        
        
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
        self.filteredYemeklerListe = yemeklerListesi
        DispatchQueue.main.async {
            self.yemeklerTableView.reloadData()
        }
    }
}



extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        yemeklerSearchBar.placeholder = "\(yemeklerListe.count) yemek arasında ara"
        return filteredYemeklerListe.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yemek = filteredYemeklerListe[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = filteredYemeklerListe[indexPath.row]
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

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredYemeklerListe = self.yemeklerListe.filter{yemek in
            if yemek.yemek_adi!.lowercased().contains(searchText.lowercased()){
                return true
            }
            if searchText == ""{
                return true
            }
            return false
        }
        self.yemeklerTableView.reloadData()
    }
}

