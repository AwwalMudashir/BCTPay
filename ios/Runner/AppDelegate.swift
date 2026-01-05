import UIKit
import Flutter
import flutter_local_notifications

// import momo_vn

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    ///Local notification config

     // This is required to make any communication available in the action isolate.
  FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)
  }
    if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
// if (@available(iOS 10.0, *)) {
//   [UNUserNotificationCenter currentNotificationCenter].delegate = (id<UNUserNotificationCenterDelegate>) self;
// }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    // override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    //         MoMoPayment.handleOpenUrl(url: url, sourceApp: sourceApplication!)
    //         return true
    //     }

    // override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    //         MoMoPayment.handleOpenUrl(url: url, sourceApp: "")
    //         return true
    //     }
}
