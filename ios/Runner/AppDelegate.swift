import Flutter
import UIKit
import Firebase

@UIApplicationMain
override func application(
  _ application: UIApplication,
  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
  FirebaseApp.configure()
  return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}

