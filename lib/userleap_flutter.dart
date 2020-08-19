import 'dart:async';

import 'package:flutter/services.dart';
import 'package:userleap_flutter/channels.dart';

class UserleapFlutter {
  static const MethodChannel _channel = const MethodChannel('userleap_flutter');

  static bool get isPluginInitialized => _isPluginInitialized;
  static bool _isPluginInitialized = false;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> configure(String environmentId) async {
    var status =
        await _channel.invokeMethod(Channels.CONFIGURE, {'env': environmentId});
    if (status as bool) _isPluginInitialized = true;
  }

  static Future<void> presentDebugSurvey() async {
    return await _channel.invokeMethod(Channels.PRESENT_DEBUG_SURVEY);
  }

  static Future<void> setUserIdentifier(String userId) async {
    return await _channel
        .invokeMethod(Channels.SET_USER_IDENTIFIER, {'userId': userId});
  }

  static Future<void> setEmailAddress(String email) async {
    try {
      return await _channel
          .invokeMethod(Channels.SET_EMAIL_ADDRESS, {'email': email});
    } catch (e) {
      print(e);
    }
  }

  _handle(Future call) async {
    try {} catch (e) {}
  }

  static Future<void> setVisitorAttribute(String key, String value) async {
    return await _channel.invokeMethod(
        Channels.SET_VISITOR_ATTRIBUTE, {'key': key, 'value': value});
  }

  static Future<void> logout() async {
    return await _channel.invokeMethod(Channels.LOGOUT);
  }

  static Future<void> track(String event) async {
    var res = await _channel.invokeMethod(Channels.TRACK, {'email': event});
    print(res);
  }
}
