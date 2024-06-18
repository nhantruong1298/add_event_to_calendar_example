import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:add_event_to_calendar/add_event_to_calendar_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelAddEventToCalendar platform = MethodChannelAddEventToCalendar();
  const MethodChannel channel = MethodChannel('add_event_to_calendar');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return true;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('addEventCalendar', () async {
    expect(
        await platform.add(
          'Event Title',
          DateTime.now(),
          DateTime.now().add(const Duration(hours: 1)),
        ),
        true);
  });
}
