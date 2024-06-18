import 'package:flutter_test/flutter_test.dart';
import 'package:add_event_to_calendar/add_event_to_calendar.dart';
import 'package:add_event_to_calendar/add_event_to_calendar_platform_interface.dart';
import 'package:add_event_to_calendar/add_event_to_calendar_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAddEventToCalendarPlatform
    with MockPlatformInterfaceMixin
    implements AddEventToCalendarPlatform {
  @override
  Future<bool?> add(String title, DateTime startDate, DateTime endDate) {
    return Future.value(true);
  }
}

void main() {
  final AddEventToCalendarPlatform initialPlatform =
      AddEventToCalendarPlatform.instance;

  test('$MethodChannelAddEventToCalendar is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAddEventToCalendar>());
  });

  test('getPlatformVersion', () async {
    AddEventToCalendar addEventToCalendarPlugin = AddEventToCalendar();
    MockAddEventToCalendarPlatform fakePlatform =
        MockAddEventToCalendarPlatform();
    AddEventToCalendarPlatform.instance = fakePlatform;

    expect(
        await addEventToCalendarPlugin.add(
          'Event Title',
          DateTime.now(),
          DateTime.now().add(const Duration(hours: 1)),
        ),
        true);
  });
}
