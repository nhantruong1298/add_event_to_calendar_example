package com.add_event_to_calendar.add_event_to_calendar

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.provider.CalendarContract
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AddEventToCalendarPlugin */
class AddEventToCalendarPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var context: Context? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "add_event_to_calendar")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "add") {
        var addEventResult = add(
          call.argument("title")!!,
          call.argument("startDate")!!,
          call.argument("endDate")!!
        );

        result.success(addEventResult)

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  fun add(title: String,startDate: Long,endDate: Long): Boolean{
    val mContext: Context = if (activity != null) activity!!.applicationContext else context!!

    val intent = Intent(Intent.ACTION_INSERT)
      .setData(CalendarContract.Events.CONTENT_URI)
      .putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, startDate)
      .putExtra(CalendarContract.EXTRA_EVENT_END_TIME, endDate)
      .putExtra(CalendarContract.Events.TITLE, title)

    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

    if (intent.resolveActivity(mContext.packageManager) != null) {
      mContext.startActivity(intent)
      return true
    }
    return false;
  }

}
