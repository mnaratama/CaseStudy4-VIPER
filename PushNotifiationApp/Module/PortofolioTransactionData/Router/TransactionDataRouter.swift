//
//  TransactionDataRouter.swift
//  ProtofolioApp
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol TransactionDataRouterProtocol {
    static func createModule(transactionData: [TransactionData]) -> UIViewController
}

class TransactionDataRouter: TransactionDataRouterProtocol {
    static func createModule(transactionData: [TransactionData]) -> UIViewController {
        let viewController = TransactionDataViewController(nibName: nil, bundle: nil)
        let presenter = TransactionDataPresenter(view: viewController, transactionData: transactionData)
        viewController.presenter = presenter
        
        return viewController
    }
}
