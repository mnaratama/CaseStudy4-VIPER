//
//  PotofolioRouter.swift
//  ProtofolioApp
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol PortofolioRouterProtocol {
    static func createModule(navigateToTransactionData: @escaping (PortofolioPieData) -> Void) -> UIViewController
    func routeToTransactionData(transactionData: PortofolioPieData)
}

class PortofolioRouter: PortofolioRouterProtocol {
    
    var navigateToTransactionData: (PortofolioPieData) -> Void = {_ in}
    
    static func createModule(navigateToTransactionData: @escaping (PortofolioPieData) -> Void) -> UIViewController {
        let vc = PortofolioViewController(nibName: nil, bundle: nil)
        let interactor = PortofolioInteractor()
        let router = PortofolioRouter()
        router.navigateToTransactionData = navigateToTransactionData
        
        let presenter = PortofolioPresenter(view: vc, interactor: interactor, router: router)
        
        vc.presenter = presenter
        interactor.presenter = presenter
        
        return vc
    }
    
    func routeToTransactionData(transactionData: PortofolioPieData) {
        navigateToTransactionData(transactionData)
    }
    
}
