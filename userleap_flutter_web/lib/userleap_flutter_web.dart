import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:userleap_flutter_platform_interface/channels.dart';

import 'userleap.dart';

/// A web implementation of the UserleapFlutterWeb plugin.
class UserleapFlutterWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      Channels.CHANNEL,
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = UserleapFlutterWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  // final userLeap = html.window.userLeap;

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case Channels.CONFIGURE:
        userLeap('configure', call.arguments['env']);
        return 'UNKNOWN';
      case Channels.DISPLAY_WITH_ID:
        displaySurvey(call.arguments['id']);
        return 'displaying survey';
      case Channels.LOGOUT:
        logoutUser();
        return 'logged out user succesfully';
      case Channels.PRESENT_DEBUG_SURVEY:
        userLeap('track', '1');
        return 'UNKNOWN';
      case Channels.SET_EMAIL_ADDRESS:
        userLeap('setEmail', call.arguments['email']);
        return 'email address set succesfully';
      case Channels.SET_VISITOR_ATTRIBUTE:
        userLeap(
            'setAttribute', call.arguments['key'], call.arguments['value']);
        return 'set visitor attribute';
      case Channels.SET_USER_IDENTIFIER:
        userLeap('setUserId', call.arguments['userId']);
        return 'set user ID';
      case Channels.TRACK:
        userLeap('track', call.arguments['env']);
        return 'UNKNOWN';

      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'userleap_flutter_web for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  /// Returns a [String] containing the version of the platform.
  Future<String> getPlatformVersion() {
    final version = html.window.navigator.userAgent;
    return Future.value(version);
  }
}
