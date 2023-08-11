//
//  TransactionResultRouter.swift
//  PushNotifiationApp
//
//  Created by Naratama on 11/08/23.
//

import UIKit

protocol TransactionResultRouterProtocol {
    static func createModule(result: TransactionResultEntity) -> UIViewController
}

class TransactionResultRouter: TransactionResultRouterProtocol {
    
    static func createModule(result: TransactionResultEntity) -> UIViewController {
        let vc = TransactionResultViewController(nibName: nil, bundle: nil)
        let presenter = TransactionResultPresenter(view: vc, transactionResult: result)
        vc.presenter = presenter
        
        return vc
    }
    
    
}
