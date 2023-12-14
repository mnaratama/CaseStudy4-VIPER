//
//  SceneDelegate.swift
//  PushNotifiationApp
//
//  Created by Naratama on 11/08/23.
//

import UIKit
import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        if UserDefaults.standard.object(forKey: "userSaldo") == nil || UserDefaults.standard.object(forKey: "userSaldo") as! Int == 0 {
            UserDefaults.standard.set(150000, forKey: "userSaldo")
        }
        
        if UserDefaults.standard.object(forKey: "userTransaction") == nil {
            UserDefaults.standard.set([] as [[String: Any]], forKey: "userTransaction")
        }
                
        let window = UIWindow(windowScene: windowScene)
        let tabBarController = UITabBarController()
        
        let qrisVC = UINavigationController(rootViewController: HomeRouter.createModule(routeToScanQR: {
            guard let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else {
                return
            }

            if let navigationController = tabBarController.viewControllers?.first as? UINavigationController {
                let scanQRVC = ScanQRRouter.createModule(navigateToPaymentDetailModule: { qrCode in
                    let paymentDetailVC = PaymentDetailRouter.createModule(with: qrCode)
                    navigationController.pushViewController(paymentDetailVC, animated: true)
                })
                navigationController.pushViewController(scanQRVC, animated: true)
            }
        }, routeToTransactionHistory: {
            guard let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else {
                return
            }

            if let navigationController = tabBarController.viewControllers?[0] as? UINavigationController {
                let transactionHistoryVC = TransactionHistoryRouter.createModule()
                navigationController.pushViewController(transactionHistoryVC, animated: false)
            }
        }))
        
        let promoVC = UINavigationController(rootViewController: PromoListRouter.createModule(navigateToPromoDetail: { promo in
            if let topController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                let promoDetailEntity = PromoDetailEntity(promoTitle: promo.promoName!, promoDesc: promo.promoDescription!, promoImageURL: promo.promoImageMediumURL!)
                let vc = PromoDetailRouter.createModule(entity: promoDetailEntity)
                topController.visibleViewController?.navigationController?.pushViewController(vc, animated: true)
            }
        }))
        
        let portfolioVC = UINavigationController(rootViewController:PortofolioRouter.createModule(navigateToTransactionData: { data in
            if let topController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
                let transactionData: [TransactionData] = data.transaction.map {
                    let dateFormatter = DateFormatter()
                    let dataLabel = TransactionType(rawValue: data.label) ?? .qr
                    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                    
                    return TransactionData(transactionType: dataLabel, transactionDate: dateFormatter.date(from: $0.trx_date) ?? Date(), amount: $0.nominal)
                }
                let vc = TransactionDataRouter.createModule(transactionData: transactionData)
                
                if let navigationController = topController.viewControllers?[2] as? UINavigationController {
                    navigationController.pushViewController(vc, animated: true)
                }
            }
        }))
        
        qrisVC.tabBarItem = UITabBarItem(title: "QRIS", image: UIImage(systemName: "qrcode"),selectedImage: UIImage(systemName: "qrcode.fill"))
        promoVC.tabBarItem = UITabBarItem(title: "Promo", image: UIImage(systemName: "tag"),selectedImage: UIImage(systemName: "tag.fill"))
        portfolioVC.tabBarItem = UITabBarItem(title: "Portfolio", image: UIImage(systemName: "dollarsign"),selectedImage: UIImage(systemName: "dollarsign.fill"))
        
        tabBarController.viewControllers = [qrisVC, promoVC, portfolioVC]
        
        self.window = window
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
       
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

