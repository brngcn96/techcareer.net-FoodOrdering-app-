//
//  AnasayfaInteractor.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 11.12.2021.
//


import Foundation
import Alamofire

class AnasayfaInteractor : PresenterToInteractorAnasayfaProtocol {
    
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    
    func tumYemekleriAl() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).responseJSON{ response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    var liste = [Yemek]()
                    if let gelenListe = cevap.yemekler {
                        liste = gelenListe
                    }
                    
                    self.anasayfaPresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }

    }
    
    /*
    
    func yemekAra(aramaKelimesi: String) {
        let params:Parameters = ["yemek_adi":aramaKelimesi]
        
        AF.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php",method: .post,parameters: params).responseJSON{ response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    var liste = [Yemek]()
                    if let gelenListe = cevap.yemekler {
                        liste = gelenListe
                    }
                    
                    self.anasayfaPresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
     
     */
    
    func yemekSil(yemek_id: String) {
        let params:Parameters = ["yemek_id":yemek_id]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).responseJSON{ response in
            
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        self.tumYemekleriAl()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}

