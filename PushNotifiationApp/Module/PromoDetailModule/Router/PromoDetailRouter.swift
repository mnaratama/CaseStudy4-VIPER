//
//  PromoDetailRouter.swift
//  PromoList
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol PromoDetailRouterProtocol {
    static func createModule(entity: PromoDetailEntity) -> UIViewController
}

class PromoDetailRouter: PromoDetailRouterProtocol {
    static func createModule(entity: PromoDetailEntity) -> UIViewController {
        let vc = PromoDetailViewController(nibName: nil, bundle: nil)
        let presenter = PromoDetailPresenter(view: vc, promoDetailEntity: entity)
        vc.presenter = presenter
        return vc
    }
}
