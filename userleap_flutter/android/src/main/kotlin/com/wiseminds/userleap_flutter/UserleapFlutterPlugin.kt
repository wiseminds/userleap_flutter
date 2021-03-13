package com.wiseminds.userleap_flutter

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import androidx.fragment.app.FragmentActivity
import com.userleap.SurveyState
import com.userleap.UserLeap
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

// const val TAG = "UserleapFlutterPlugin"

/** UserleapFlutterPlugin */
class UserleapFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

    companion object {
    const val TAG = "UserleapFlutterPlugin"
  }

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mContext: Context
  private  lateinit var mActivity: FragmentActivity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "plugins.flutter.io/userleap_flutter")
    channel.setMethodCallHandler(this)
    this.mContext = flutterPluginBinding.applicationContext;
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
          "configure" -> configure(call.argument<String>("env"), result)
          "setUserIdentifier" -> {
            call.argument<String>("userId")?.let {
              UserLeap.setUserIdentifier(it)
              result.success("Sent userId to Userleap")
            }
          }
          "setEmailAddress" -> {
            call.argument<String>("email")?.let {
              UserLeap.setEmailAddress(it)
              result.success("Sent email to Userleap")
            }
          }
           "displaySurveyWithId" -> {
            call.argument<Int>("id")?.let {
//              UserLeap.displaySurveyWithId(it)
              result.success("This feature is not yet available on android")
            }
          }
          "logout" ->  UserLeap.logout()
          "presentDebugSurvey" ->  UserLeap.presentDebugSurvey(mActivity)
          "setVisitorAttribute" ->  UserLeap.setVisitorAttribute(call.argument<String>("key")!!,
                  call.argument<String>("value")!!)
          "track" ->  track(call.argument<String>("event")!!, result)
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun track(event: String,  result: Result) {
    UserLeap.track(event) { surveyState ->
      when (surveyState) {
        SurveyState.READY -> {
          // We received a survey for the event, present it to the user
          UserLeap.presentSurvey(mActivity)
          result.success("READY")
        }
        SurveyState.NO_SURVEY -> {
          // No survey available based on event
          result.success("NO_SURVEY")
        }
        SurveyState.DISABLED -> {
          // UserLeap has been disabled remotely
          result.success("DISABLED")
        }
      }
    }
  }

  private fun configure(env: String?, result: Result) {
    if(env != null) {
    UserLeap.configure(this.mContext, env)
    Log.d(TAG, "Configured plugin successfully")
      result.success(true)
    }
    else {
      Log.d(TAG, "Could not configure plugin")
      result.success(false)
    }
  }

  override fun onDetachedFromActivity() {
//    mActivity = null
    Log.d(TAG, "DetachedFromActivity")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    mActivity = binding.activity as FragmentActivity
    Log.d(TAG, "ReattachedToActivityForConfigChanges")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mActivity = binding.activity as FragmentActivity
    Log.d(TAG, "onAttachedToActivity")
  }

  override fun onDetachedFromActivityForConfigChanges() {
    Log.d(TAG, "onDetachedFromActivityForConfigChanges")
  }


}
