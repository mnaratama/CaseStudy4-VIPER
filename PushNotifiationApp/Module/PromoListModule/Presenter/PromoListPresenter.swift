//
//  PromoListPresenter.swift
//  PromoList
//
//  Created by Naratama on 10/08/23.
//

import Foundation

protocol PromoListPresenterProtocol {
    func getPromoList()
    func presentEmptyPromoList()
    func presentPromoList(entity: PromoListViewEntity)
    func presentGetErrorPromo(entity: PromoListViewEntity)
    func presentPromoDetail(entity: PromoListEntity)
}

class PromoListPresenter: PromoListPresenterProtocol {
   
    var view: PromoListViewProtocol
    var interactor: PromoListInteractorProtocol
    var router: PromoListRouterProtocol
    
    init(view: PromoListViewProtocol, interactor: PromoListInteractorProtocol, router: PromoListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func presentPromoList(entity: PromoListViewEntity) {
        view.displayPromoList(entity: entity)
    }
    
    func getPromoList() {
        interactor.fetchPromoList()
    }
    
    func presentEmptyPromoList() {
        view.displayPromoEmpty()
    }
    
    func presentGetErrorPromo(entity: PromoListViewEntity) {
        view.displayPromoError(error: entity.errors)
    }
    
    func presentPromoDetail(entity: PromoListEntity) {
        router.routeToPromoDetail(entity: entity)
    }
    
}
