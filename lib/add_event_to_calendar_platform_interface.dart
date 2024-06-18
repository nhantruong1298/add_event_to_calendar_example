import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'add_event_to_calendar_method_channel.dart';

abstract class AddEventToCalendarPlatform extends PlatformInterface {
  /// Constructs a AddEventToCalendarPlatform.
  AddEventToCalendarPlatform() : super(token: _token);

  static final Object _token = Object();

  static AddEventToCalendarPlatform _instance =
      MethodChannelAddEventToCalendar();

  /// The default instance of [AddEventToCalendarPlatform] to use.
  ///
  /// Defaults to [MethodChannelAddEventToCalendar].
  static AddEventToCalendarPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AddEventToCalendarPlatform] when
  /// they register themselves.
  static set instance(AddEventToCalendarPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> add(String title, DateTime startDate, DateTime endDate) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
