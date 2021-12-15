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
    
    func tumSepetiAl() {
        
        
        let params:Parameters=["kullanici_adi":"baran"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).responseJSON{ response in
        
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(SepetCevap.self, from: data)
                    var liste = [SepetEleman]()
                    if let gelenListe = cevap.sepet_yemekler {
                        liste = gelenListe
                    }
                    
                    self.sepetPresenter?.presenteraVeriGonder(sepetListesi: liste)
                    
                    
                    //print(liste[0].yemek_adi!)
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }

    }

    
    func yemekSil(sepet_yemek_id: String) {
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":"baran"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).responseJSON{ response in
            
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        self.tumSepetiAl()
                    
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}

