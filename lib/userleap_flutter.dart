import 'dart:async';

import 'package:flutter/services.dart';
import 'package:userleap_flutter/channels.dart';

/// UserleapFlutter Plugin
class UserleapFlutter {
  static const MethodChannel _channel = const MethodChannel('userleap_flutter');

  static bool get isPluginInitialized => _isPluginInitialized;
  static bool _isPluginInitialized = false;

// initialize SDK with your environment id, this must be done befor calling any other methods
// Note: configure will only accept 1 environment id, calling it multiple times
// with different IDs will have no effect.
  static Future configure(String environmentId) async {
    await _channel.invokeMethod(Channels.CONFIGURE, {'env': environmentId});
    // if (status as bool) _isPluginInitialized = true;
  }

  ///  verify you’ve set up the installation and environment ID
  static Future presentDebugSurvey() async {
    return await _channel.invokeMethod(Channels.PRESENT_DEBUG_SURVEY);
  }

  /// Set the userId after configuring if they are already logged in or after the user logs in to your app:
  /// This user identifier is stored locally and this method can be called multiple times safely.
  /// We recommend you set the user identifier every time you configure UserLeap and anytime your
  /// customers login to be safe
  /// UserLeap allows you to identify visitors by supplying a userId.
  ///  While tracking userIds is optional,  it helps to provide a consistent
  ///  experience across platforms and prevents users from seeing the same
  /// survey multiple times
  static Future setUserIdentifier(String userId) async {
    return await _channel
        .invokeMethod(Channels.SET_USER_IDENTIFIER, {'userId': userId});
  }

  /// Set the user email after configuring if they are already logged in or after the user logs in to your app
  static Future setEmailAddress(String email) async {
    try {
      return await _channel
          .invokeMethod(Channels.SET_EMAIL_ADDRESS, {'email': email});
    } catch (e) {
      print(e);
    }
  }

  /// display a survey using the survey id, this method is currently only available on IOS
  static Future displaySurveyWithId(int id) async {
    try {
      return await _channel.invokeMethod(Channels.DISPLAY_WITH_ID, {'id': id});
    } catch (e) {
      print(e);
    }
  }

  /// There are various other properties you may want to set.
  /// These properties are surfaced as survey targeting options
  ///  in the UserLeap dashboard and allow you to send surveys to
  /// the right user segments.
  static Future setVisitorAttribute(String key, String value) async {
    return await _channel.invokeMethod(
        Channels.SET_VISITOR_ATTRIBUTE, {'key': key, 'value': value});
  }

  /// When a user logs out of your app, make sure to log out of Userleap. This will prevent new activity
  /// being associated with the wrong user.
  static Future logout() async {
    return await _channel.invokeMethod(Channels.LOGOUT);
  }

  /// track a specific event defined on your dashboard
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

/// possible status returned from track event
enum SurveryStatus { ready, nosurvey, disabled }
