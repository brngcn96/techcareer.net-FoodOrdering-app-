//
//  YemekDetayProtocols.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 13.12.2021.
//

import Foundation

protocol ViewToPresenterYemekDetayProtocol {
    var yemekDetayInteractor:PresenterToInteractorYemekDetayProtocol? {get set}
    
    func yemekEkle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}

protocol PresenterToInteractorYemekDetayProtocol {
    func sepeteYemekEkle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}

protocol PresenterToRouterYemekDetayProtocol {
    static func createModule(ref:YemekDetayVC)
}
