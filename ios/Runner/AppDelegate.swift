import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Read GoogleService-Info.plist and find the API key
    //Load content of Info.plist into resourceFileDictionary dictionary
    if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
      let resourceFileDictionary = NSDictionary(contentsOfFile: path)
      if let resourceFileDictionaryContent = resourceFileDictionary {
        if let apiKey = resourceFileDictionaryContent.object(forKey: "API_KEY") {
            GMSServices.provideAPIKey("\(apiKey)") // <-- Google Maps initialization
        }
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
