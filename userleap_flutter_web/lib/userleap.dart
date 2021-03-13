@JS()
library userleap;

import 'package:js/js.dart';

@JS('UserLeap')
external userLeap(String event, [dynamic? key, dynamic? value]);

@JS('UserLeap.logoutUser')
external void logoutUser();

@JS('UserLeapdisplaySurvey')
external void displaySurvey(String id);
