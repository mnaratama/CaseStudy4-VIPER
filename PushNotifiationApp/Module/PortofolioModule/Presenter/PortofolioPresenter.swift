//
//  PortofolioPresenter.swift
//  ProtofolioApp
//
//  Created by Naratama on 10/08/23.
//

import Foundation

protocol PortofolioPresenterProtocol {
    func presentData()
    func presentPieChart(data: [PortofolioPieData])
    func presentToTransactionData(transactionData: PortofolioPieData)
}

class PortofolioPresenter: PortofolioPresenterProtocol {
   
    var view: PortofolioViewProtocol
    var interactor: PortofolioInteractorProtocol
    var router: PortofolioRouterProtocol
    
    init(view: PortofolioViewProtocol, interactor: PortofolioInteractorProtocol, router: PortofolioRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func presentData() {
        interactor.preparePieData()
    }
    
    func presentPieChart(data: [PortofolioPieData]) {
        view.displayDataChart(data: data)
    }
    
    func presentToTransactionData(transactionData: PortofolioPieData) {
        router.routeToTransactionData(transactionData: transactionData)
    }
    
}
