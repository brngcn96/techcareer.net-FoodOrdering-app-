//
//  SepetRouter.swift
//  FoodOrderingApp
//
//  Created by Baran Göcen on 14.12.2021.
//
import Foundation

class SepetRouter : PresenterToRouterSepetProtocol {
    static func createModule(ref: SepetVC) {
        let presenter : ViewToPresenterSepetProtocol & InteractorToPresenterSepetProtocol = SepetPresenter()
        
        //View controller için
        ref.sepetPresenterNesnesi = presenter
        
        //Presenter için
        ref.sepetPresenterNesnesi?.sepetInteractor = SepetInteractor()
        ref.sepetPresenterNesnesi?.sepetView = ref
        
        //Interactor için
        
        ref.sepetPresenterNesnesi?.sepetInteractor?.sepetPresenter = presenter
    }
}
