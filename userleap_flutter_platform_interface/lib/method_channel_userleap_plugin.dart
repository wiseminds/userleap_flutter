// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/services.dart';

import 'channels.dart';
import 'userleap_flutter_platform_interface.dart';

const MethodChannel _channel = MethodChannel(Channels.CHANNEL);

/// An implementation of [UrlLauncherPlatform] that uses method channels.
class MethodChannelUserleapPlugin extends UserleapFlutterPlatform {
  bool get isPluginInitialized => _isPluginInitialized;
  bool _isPluginInitialized = false;
  @override
  Future configure(String environmentId) async {
    await _channel.invokeMethod(Channels.CONFIGURE, {'env': environmentId});
    _isPluginInitialized = true;
  }

  @override
  Future presentDebugSurvey() async {
    return await _channel.invokeMethod(Channels.PRESENT_DEBUG_SURVEY);
  }

  @override
  Future setUserIdentifier(String userId) async {
    return await _channel
        .invokeMethod(Channels.SET_USER_IDENTIFIER, {'userId': userId});
  }

  @override
  Future setEmailAddress(String email) async {
    try {
      return await _channel
          .invokeMethod(Channels.SET_EMAIL_ADDRESS, {'email': email});
    } catch (e) {
      print(e);
    }
  }

  @override
  Future displaySurveyWithId(int id) async {
    try {
      return await _channel.invokeMethod(Channels.DISPLAY_WITH_ID, {'id': id});
    } catch (e) {
      print(e);
    }
  }

  @override
  Future setVisitorAttribute(String key, String value) async {
    return await _channel.invokeMethod(
        Channels.SET_VISITOR_ATTRIBUTE, {'key': key, 'value': value});
  }

  @override
  Future logout() async {
    return await _channel.invokeMethod(Channels.LOGOUT);
  }

  @override
  Future<SurveryStatus> track(String event) async {
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
