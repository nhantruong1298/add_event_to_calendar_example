import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'add_event_to_calendar_platform_interface.dart';

/// An implementation of [AddEventToCalendarPlatform] that uses method channels.
class MethodChannelAddEventToCalendar extends AddEventToCalendarPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('add_event_to_calendar');

  @override
  Future<bool?> add(String title, DateTime startDate, DateTime endDate) async {
    final result = await methodChannel.invokeMethod<bool>('add', {
      'title': title,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
    });
    return result;
  }
}
