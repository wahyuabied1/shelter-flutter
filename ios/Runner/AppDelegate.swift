import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

     let controller = window?.rootViewController as! FlutterViewController
            let channel = FlutterMethodChannel(name: "com.shelter.indonesia.superapps/platformInfo", binaryMessenger: controller.binaryMessenger)
            channel.setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                if call.method == "isDebuggerConnected" {
                    result(self.isDebugger())
                } else if call.method == "isEmulator"{
                    result(self.isRunningOnSimulator())
                } else if call.method == "getFlavor" {
                    result(self.getFlavor())
                } else {
                    result(FlutterMethodNotImplemented)
                }
            })
    if #available(iOS 16, *) {
    UNUserNotificationCenter.current().setBadgeCount(0, withCompletionHandler: { error in
    })
    } else {
    UIApplication.shared.applicationIconBadgeNumber = 0
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application: UIApplication, continue userActivity:NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
          // clear all view above FlutterViewController
        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
        return super.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }

    func isDebugger() -> Bool {
        var info = kinfo_proc()
              var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]

              var size = MemoryLayout.stride(ofValue: info)
              let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)

              assert(junk == 0, "sysctl failed")
              assert(size == MemoryLayout.stride(ofValue: info), "size mismatch")
        return (info.kp_proc.p_flag & P_TRACED) != 0
      }

      func getFlavor() -> String {
      var config: [String: Any]?

      if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
          do {
              let infoPlistData = try Data(contentsOf: infoPlistPath)

              if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                  config = dict
              }
          } catch {
              print(error)
          }
      }

      // Use optional binding to safely unwrap the value and provide a default value if needed
      if let flavor = config?["FLAVOR"] as? String {
          return flavor
      } else {
          // Provide a default value or handle the absence of the "FLAVOR" key accordingly
          return "dev"
      }
  }

      func isRunningOnSimulator() -> Bool {
          #if targetEnvironment(simulator)
              return true
          #else
              return false
          #endif
      }
}
