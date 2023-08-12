//
//  AppDelegate.swift
//  PushNotifiationApp
//
//  Created by Naratama on 11/08/23.
//

import UIKit
import FirebaseMessaging
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        handleNotification(userInfo: userInfo)
        completionHandler(.newData)
    }
    
    func handleNotification(userInfo: [AnyHashable: Any]) {
        if let deepLink = userInfo["deepLink"] as? String, let url = URL(string: deepLink) {
            if let scheme = url.scheme, scheme == "sample.id" {
                let pathComponents = url.pathComponents
                
                var parameters = [String: String]()
                URLComponents(string: deepLink)?.queryItems?.forEach { parameters[$0.name] = $0.value }
                
                if let page = pathComponents.last, page == "result", let title = parameters["title"], let transactionCode = parameters["transactionCode"] {
                    showTransactionResult(title: title, transactionCode: transactionCode)
                }
            }
        }
    }
    
    
    func showTransactionResult(title: String, transactionCode: String) {
        
        let resultViewController = TransactionResultRouter.createModule(result: .init(transactionCode: transactionCode, transactionStatus: title))
        
        let window = UIWindow()
        
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.pushViewController(resultViewController, animated: true)
        }
    }
}

