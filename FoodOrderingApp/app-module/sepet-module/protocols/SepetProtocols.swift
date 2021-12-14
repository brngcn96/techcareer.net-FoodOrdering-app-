//
//  SepetProtocols.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 14.12.2021.
//

import Foundation


protocol ViewToPresenterSepetProtocol {
    var sepetInteractor:PresenterToInteractorSepetProtocol? {get set}
    var sepetView:PresenterToViewSepetProtocol? {get set}
    
    func sepettekileriYukle()
    func sil(sepet_yemek_id:String)
}

protocol PresenterToInteractorSepetProtocol {
    var anasayfaPresenter:InteractorToPresenterAnasayfaProtocol? {get set}
    
    func tumSepetiAl()

    func yemekSil(sepet_yemek_id:String)
}

protocol InteractorToPresenterSepetProtocol {
    func presenteraVeriGonder(sepetListesi:Array<SepetEleman>)
}

protocol PresenterToViewSepetProtocol {
    func vieweVeriGonder(sepetListesi:Array<SepetEleman>)
}

protocol PresenterToRouterSepetProtocol {
    static func createModule(ref:SepetVC)
}
