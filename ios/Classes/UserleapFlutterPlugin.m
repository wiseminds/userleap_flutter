#import "UserleapFlutterPlugin.h"
#if __has_include(<userleap_flutter/userleap_flutter-Swift.h>)
#import <userleap_flutter/userleap_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "userleap_flutter-Swift.h"
#endif

@implementation UserleapFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUserleapFlutterPlugin registerWithRegistrar:registrar];
}
@end
