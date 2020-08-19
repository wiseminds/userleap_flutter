
import 'dart:async';

import 'package:flutter/services.dart';

class UserleapFlutter {
  static const MethodChannel _channel =
      const MethodChannel('userleap_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
