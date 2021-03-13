library userleap_flutter_platform_interface;

import 'method_channel_userleap_plugin.dart';

/// possible status returned from track event
enum SurveryStatus { ready, nosurvey, disabled }

abstract class UserleapFlutterPlatform {
  // indicates if pugin has been initialised by calling configure
  bool get isPluginInitialized;

  /// The default instance of [UserleapFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelUserleapPlugin].
  static UserleapFlutterPlatform _instance = MethodChannelUserleapPlugin();

  /// The default instance of [UserleapFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelUserleapPlugin].
  static UserleapFlutterPlatform get instance => _instance;

// initialize SDK with your environment id, this must be done befor calling any other methods
// Note: configure will only accept 1 environment id, calling it multiple times
// with different IDs will have no effect.
  Future configure(String environmentId) async {
    throw UnimplementedError(
      'configure() has not been implemented.',
    );
  }

  ///  verify you’ve set up the installation and environment ID
  Future presentDebugSurvey() async {
    throw UnimplementedError(
      'presentDebugSurvey() has not been implemented.',
    );
  }

  /// Set the userId after configuring if they are already logged in or after the user logs in to your app:
  /// This user identifier is stored locally and this method can be called multiple times safely.
  /// We recommend you set the user identifier every time you configure UserLeap and anytime your
  /// customers login to be safe
  /// UserLeap allows you to identify visitors by supplying a userId.
  ///  While tracking userIds is optional,  it helps to provide a consistent
  ///  experience across platforms and prevents users from seeing the same
  /// survey multiple times
  Future setUserIdentifier(String userId) async {
    throw UnimplementedError(
      'setUserIdentifier() has not been implemented.',
    );
  }

  /// Set the user email after configuring if they are already logged in or after the user logs in to your app
  Future setEmailAddress(String email) async {
    throw UnimplementedError(
      'setEmailAddress() has not been implemented.',
    );
  }

  /// display a survey using the survey id, this method is currently only available on IOS
  Future displaySurveyWithId(int id) async {
    throw UnimplementedError(
      'displaySurveyWithId() has not been implemented.',
    );
  }

  /// There are various other properties you may want to set.
  /// These properties are surfaced as survey targeting options
  ///  in the UserLeap dashboard and allow you to send surveys to
  /// the right user segments.
  Future setVisitorAttribute(String key, String value) async {
    throw UnimplementedError(
      'setVisitorAttribute() has not been implemented.',
    );
  }

  /// When a user logs out of your app, make sure to log out of Userleap. This will prevent new activity
  /// being associated with the wrong user.
  Future logout() async {
    throw UnimplementedError(
      'logout() has not been implemented.',
    );
  }

  /// track a specific event defined on your dashboard
  Future<SurveryStatus> track(String event) async {
    throw UnimplementedError(
      'track() has not been implemented.',
    );
  }
}
