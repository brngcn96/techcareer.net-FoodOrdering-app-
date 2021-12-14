//
//  SepetInteractor.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 14.12.2021.
//

import Foundation

import Foundation
import Alamofire

class SepetInteractor : PresenterToInteractorSepetProtocol {
    var sepetPresenter: InteractorToPresenterSepetProtocol?
    
    func sepettekileriAl() {
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .get).responseJSON{ response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)
                    var liste = [SepetEleman]()
                    if let gelenListe = cevap.sepet_yemekler {
                        liste = gelenListe
                    }
                    
                    self.sepetPresenter?.presenteraVeriGonder(sepetListesi: liste)
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }

    }
    
    func kisiAra(aramaKelimesi: String) {
        let params:Parameters = ["kisi_ad":aramaKelimesi]
        
        Alamofire.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php",method: .post,parameters: params).responseJSON{ response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(KisilerCevap.self, from: data)
                    var liste = [Kisiler]()
                    if let gelenListe = cevap.kisiler {
                        liste = gelenListe
                    }
                    
                    self.anasayfaPresenter?.presenteraVeriGonder(kisilerListesi: liste)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func yemekSil(sepet_yemek_id: Int) {
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id]
        
        AF.request("http://kasimadalan.pe.hu/kisiler/delete_kisiler.php",method: .post,parameters: params).responseJSON{ response in
            
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        self.sepettekileriAl()()
                    
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}

