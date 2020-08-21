import 'dart:async';

import 'package:flutter/services.dart';
import 'package:userleap_flutter/channels.dart';

class UserleapFlutter {
  static const MethodChannel _channel = const MethodChannel('userleap_flutter');

  static bool get isPluginInitialized => _isPluginInitialized;
  static bool _isPluginInitialized = false;

  static Future configure(String environmentId) async {
    var status =
        await _channel.invokeMethod(Channels.CONFIGURE, {'env': environmentId});
    print(status);
    // if (status as bool) _isPluginInitialized = true;
  }

  static Future presentDebugSurvey() async {
    return await _channel.invokeMethod(Channels.PRESENT_DEBUG_SURVEY);
  }

  static Future setUserIdentifier(String userId) async {
    return await _channel
        .invokeMethod(Channels.SET_USER_IDENTIFIER, {'userId': userId});
  }

  static Future setEmailAddress(String email) async {
    try {
      return await _channel
          .invokeMethod(Channels.SET_EMAIL_ADDRESS, {'email': email});
    } catch (e) {
      print(e);
    }
  }

  static Future setVisitorAttribute(String key, String value) async {
    return await _channel.invokeMethod(
        Channels.SET_VISITOR_ATTRIBUTE, {'key': key, 'value': value});
  }

  static Future logout() async {
    return await _channel.invokeMethod(Channels.LOGOUT);
  }

  static Future<SurveryStatus> track(String event) async {
    var res = await _channel.invokeMethod(Channels.TRACK, {'event': event});
    switch (res) {
      case 'READY':
        return SurveryStatus.ready;
      case 'NO_SURVEY':
        return SurveryStatus.nosurvey;
      case 'DISABLED':
      default:
        return SurveryStatus.disabled;
    }
  }
}

enum SurveryStatus { ready, nosurvey, disabled }
