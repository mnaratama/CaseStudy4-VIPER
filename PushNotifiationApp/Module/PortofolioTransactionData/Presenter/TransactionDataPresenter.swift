//
//  TransactionDataPresenter.swift
//  ProtofolioApp
//
//  Created by Naratama on 10/08/23.
//

import Foundation

protocol TransactionDataPresenterProtocol {
    func presentTableView()
}

class TransactionDataPresenter: TransactionDataPresenterProtocol {
    
    var view: TransactionDataViewProtocol
    var transactionData: [TransactionData]
    
    init(view: TransactionDataViewProtocol, transactionData: [TransactionData]) {
        self.view = view
        self.transactionData = transactionData
    }
    
    func presentTableView() {
        view.setupTableData(data: transactionData)
    }
    
}
