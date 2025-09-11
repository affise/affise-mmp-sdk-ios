import UIKit
import AffiseAttributionLib
//import AffiseSKAdNetwork

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Initialize https://github.com/affise/affise-mmp-sdk-ios#initialize
        Affise
            .settings(
                affiseAppId: "129",
                secretKey: "93a40b54-6f12-443f-a250-ebf67c5ee4d2"
            )
            .setProduction(false) //To enable debug methods set Production to false
            .setDisableModules([
                .Advertising
            ])
            .start(app: application, launchOptions: launchOptions) // Start Affise SDK       

        // Module Advertising https://github.com/affise/affise-mmp-sdk-ios#module-advertising
        // Affise.Module.Advertising.startModule()
        
        // Deeplinks https://github.com/affise/affise-mmp-sdk-ios#deeplinks
        Affise.registerDeeplinkCallback { [weak self] value in
            self?.showAlert(
                title: "Deeplink",
                message: "\"\(value.deeplink)\"\n\n" +
                "scheme: \"\(value.scheme ?? "")\"\n\n" +
                "host: \"\(value.host ?? "")\"\n\n" +
                "path: \"\(value.path ?? "")\"\n\n" +
                "parameters: \(value.parameters)"
            )
            
            if value.parameters["screen"]?.contains("special_offer") == true {
                // handle value
            }
        }
        
        // StoreKit Ad Network https://github.com/affise/affise-mmp-sdk-ios#storekit-ad-network
//        AffiseSKAd.register { error in
//            // handle error
//        }

        // StoreKit Ad Network https://github.com/affise/affise-mmp-sdk-ios#storekit-ad-network
//        AffiseSKAd.updatePostbackConversionValue(fineValue: 1, coarseValue: CoarseConversionValue.medium) { error in
//            // handle error
//        }
     
        // Get module state https://github.com/affise/affise-mmp-sdk-ios#get-module-state
//        Affise.Module.getStatus(AffiseModules.Status) { result in
//            // handle status
//        }
        
        // Debug: Validate credentials https://github.com/affise/affise-mmp-sdk-ios#validate-credentials
//        Affise.Debug.validate { status in
//            debugPrint("Affise: validate = \(status)")
//        }
               
        // Debug: network request/response
        Affise.Debug.network { (request, response) in
//            debugPrint("Affise: \(request)")
           debugPrint("Affise: \(response)")
        }
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let pushToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        Affise.addPushToken(pushToken, .APPLE)
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        // Handle Deeplink
        Affise.handleDeeplink(url)
        return true
    }
    
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        // Handle AppLinks
        Affise.handleUserActivity(userActivity)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func showAlert(title: String, message: String) {
        guard let rootViewController = self.window?.rootViewController else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        rootViewController.present(alertController, animated: true, completion: nil)
    }
}

