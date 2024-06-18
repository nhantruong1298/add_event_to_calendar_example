import 'package:flutter/material.dart';
import 'package:add_event_to_calendar/add_event_to_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _addEventToCalendarPlugin = AddEventToCalendar();

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final result = await _addEventToCalendarPlugin.add(
                'Event Title',
                DateTime.now(),
                DateTime.now().add(const Duration(hours: 1)),
              );
              print('Event added: $result');
            },
            child: const Text('Add Event'),
          )
        ),
      ),
    );
  }
}
