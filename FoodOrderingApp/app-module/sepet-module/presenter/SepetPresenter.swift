//
//  SepetPresenter.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 14.12.2021.
//

import Foundation

class SepetPresenter : ViewToPresenterSepetProtocol {
    var sepetInteractor: PresenterToInteractorSepetProtocol?
    var sepetView: PresenterToViewSepetProtocol?
    
    func sepettekileriYukle() {
        sepetInteractor?.tumSepetiAl()
    }
    
    func sil(sepet_yemek_id: String) {
        sepetInteractor?.yemekSil(sepet_yemek_id: sepet_yemek_id)
    }
}

extension AnasayfaPresenter : InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(sepetListesi: Array<SepetEleman>) {
        sepetView?.vieweVeriGonder(sepetListesi: sepetListesi)
    }
}
