import Flutter
import UIKit
import UserLeapKit

public class SwiftUserleapFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "userleap_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftUserleapFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//    result("iOS " + UIDevice.current.systemVersion)
    let method = call.method
    var arguments = call.arguments as? NSDictionary
    
    switch method {
       case "configure":
           if let env = arguments?["env"] as? String {
               UserLeap.shared.configure(withEnvironment: env)
              result("Environment ID configured successfully")
           }
        case "setEmailAddress":
            if let email = arguments?["email"] as? String {
                      UserLeap.shared.setEmailAddress(email)
                 result("Email sent to Userleap")
            }
        case "setVisitorAttribute":
        if let key = arguments?["key"] as? String {
              if let value = arguments?["value"] as? String {
               UserLeap.shared.setVisitorAttribute(key: key, value: value)
                 result("Viditor attribute sent to Userleap")
            }
            
        }
        case "setUserIdentifier":
        if let userId = arguments?["userId"] as? String {
                  UserLeap.shared.setUserIdentifier(userId)
             result("User ID sent to Userleap")
        }
          
        case "track":
            if let event = arguments?["event"] as? String {
            UserLeap.shared.track(eventName: event) { state in
                    switch state {
                        case .ready:
                             result("READY")
                            let viewController: UIViewController =
                            (UIApplication.shared.delegate?.window??.rootViewController)!;
                            UserLeap.shared.presentSurvey(from: viewController)
                    case .noSurvey:
                        result("NO_SURVEY")
                    case .disabled:
                        result("DISABLED")
                            break
                }
            }
        }
         case "displaySurveyWithId":
            if let id = arguments?["id"] as? Int {
                  let viewController: UIViewController =
                            (UIApplication.shared.delegate?.window??.rootViewController)!;
            UserLeap.shared.presentSurvey(withId: id, from: viewController) 
            // { state in
            //         switch state {
            //             case .ready:
            //                  result("READY")
            //                 let viewController: UIViewController =
            //                 (UIApplication.shared.delegate?.window??.rootViewController)!;
            //                 UserLeap.shared.presentSurvey(from: viewController)
            //         case .noSurvey:
            //             result("NO_SURVEY")
            //         case .disabled:
            //             result("DISABLED")
            //                 break
            //     }
            // }
        }
        case "presentDebugSurvey":
            let viewController: UIViewController =
                                      (UIApplication.shared.delegate?.window??.rootViewController)!;
            UserLeap.shared.presentDebugSurvey(from: viewController)
        case "logout":
        UserLeap.shared.logout()
         result("Logged out of Userleap")
        default:
        result(FlutterMethodNotImplemented)
    }
  }
}
