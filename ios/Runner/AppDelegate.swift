import UIKit
import Flutter
import  GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIkey("AIzaSyAOegRO3d43MVnEdk75Kv2ydr68BFgMERQ")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
