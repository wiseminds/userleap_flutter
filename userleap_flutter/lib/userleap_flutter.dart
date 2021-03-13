import 'dart:async';

import 'package:userleap_flutter_platform_interface/userleap_flutter_platform_interface.dart';

/// UserleapFlutter Plugin
class UserleapFlutter {

  static bool get isPluginInitialized =>  UserleapFlutterPlatform.instance.isPluginInitialized;
  

// initialize SDK with your environment id, this must be done befor calling any other methods
// Note: configure will only accept 1 environment id, calling it multiple times
// with different IDs will have no effect.
  static Future configure(String environmentId) =>
      UserleapFlutterPlatform.instance.configure(environmentId);

  ///  verify you’ve set up the installation and environment ID
  static Future presentDebugSurvey() =>
      UserleapFlutterPlatform.instance.presentDebugSurvey();

  /// Set the userId after configuring if they are already logged in or after the user logs in to your app:
  /// This user identifier is stored locally and this method can be called multiple times safely.
  /// We recommend you set the user identifier every time you configure UserLeap and anytime your
  /// customers login to be safe
  /// UserLeap allows you to identify visitors by supplying a userId.
  ///  While tracking userIds is optional,  it helps to provide a consistent
  ///  experience across platforms and prevents users from seeing the same
  /// survey multiple times
  static Future setUserIdentifier(String userId) =>
      UserleapFlutterPlatform.instance.setUserIdentifier(userId);

  /// Set the user email after configuring if they are already logged in or after the user logs in to your app
  static Future setEmailAddress(String email) =>
      UserleapFlutterPlatform.instance.setEmailAddress(email);

  /// display a survey using the survey id, this method is currently only available on IOS
  static Future displaySurveyWithId(int id) =>
      UserleapFlutterPlatform.instance.displaySurveyWithId(id);

  /// There are various other properties you may want to set.
  /// These properties are surfaced as survey targeting options
  ///  in the UserLeap dashboard and allow you to send surveys to
  /// the right user segments.
  static Future setVisitorAttribute(String key, String value) =>
      UserleapFlutterPlatform.instance.setVisitorAttribute(key, value);

  /// When a user logs out of your app, make sure to log out of Userleap. This will prevent new activity
  /// being associated with the wrong user.
  static Future logout() => UserleapFlutterPlatform.instance.logout();

  /// track a specific event defined on your dashboard
  static Future<SurveryStatus> track(String event) =>
      UserleapFlutterPlatform.instance.track(event);
}
 
