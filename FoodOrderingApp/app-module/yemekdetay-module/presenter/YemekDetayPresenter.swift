//
//  YemekDetayPresenter.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 13.12.2021.
//



import Foundation

class YemekDetayPresenter : ViewToPresenterYemekDetayProtocol {
    var yemekDetayInteractor: PresenterToInteractorYemekDetayProtocol?
    
    func yemekEkle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String) {
        yemekDetayInteractor?.sepeteYemekEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
}
 
 
