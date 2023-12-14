//
//  PromoListRouter.swift
//  PromoList
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol PromoListRouterProtocol {
    static func createModule(navigateToPromoDetail: @escaping (PromoListEntity) -> Void) -> UIViewController
    func routeToPromoDetail(entity: PromoListEntity)
}

class PromoListRouter: PromoListRouterProtocol {
    
    var navigateToRouteToPromoDetail: (PromoListEntity) -> Void = {_ in}
    
    static func createModule(navigateToPromoDetail: @escaping (PromoListEntity) -> Void) -> UIViewController {
        let viewController = PromoListViewController(nibName: nil, bundle: nil)
        let interactor = PromoListInteractor()
        let router = PromoListRouter()
        let presenter = PromoListPresenter(view: viewController, interactor: interactor, router: router)
        
        router.navigateToRouteToPromoDetail = navigateToPromoDetail
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }
    
    func routeToPromoDetail(entity: PromoListEntity) {
        navigateToRouteToPromoDetail(entity)
    }
    
    
}
