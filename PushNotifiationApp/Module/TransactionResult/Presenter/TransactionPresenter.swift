//
//  TransactionPresenter.swift
//  PushNotifiationApp
//
//  Created by Naratama on 11/08/23.
//

import Foundation

protocol TransactionResultPresenterProtocol {
    func presentStatus()
}

class TransactionResultPresenter: TransactionResultPresenterProtocol {
    
    var view: TransactionResultViewProtocol
    var transactionResult: TransactionResultEntity
    
    init(view: TransactionResultViewProtocol, transactionResult: TransactionResultEntity) {
        self.view = view
        self.transactionResult = transactionResult
    }
    
    func presentStatus() {
        view.displayPage(with: transactionResult)
    }
    
}
