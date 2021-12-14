//
//  FoodsViewProtocols.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 11.12.2021.
//

import Foundation


protocol ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView:PresenterToViewAnasayfaProtocol? {get set}
    
    func yemekleriYukle()
    //func ara(aramaKelimesi:String)
    func sil(yemek_id:String)
}

protocol PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter:InteractorToPresenterAnasayfaProtocol? {get set}
    
    func tumYemekleriAl()
    //func yemekAra(aramaKelimesi:String)
    func yemekSil(yemek_id:String)
}

protocol InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yemeklerListesi:Array<Yemek>)
}

protocol PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemeklerListesi:Array<Yemek>)
}

protocol PresenterToRouterAnasayfaProtocol {
    static func createModule(ref:ViewController)
}
