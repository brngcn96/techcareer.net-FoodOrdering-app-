//
//  YemekDetayRouter.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 13.12.2021.
//

import Foundation

class YemekDetayRouter : PresenterToRouterYemekDetayProtocol {
    static func createModule(ref: YemekDetayVC) {
        ref.yemekDetayPresenterNesnesi = YemekDetayPresenter()
        ref.yemekDetayPresenterNesnesi?.yemekDetayInteractor = YemekDetayInteractor()
    }
}
