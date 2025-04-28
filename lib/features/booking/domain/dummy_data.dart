import 'package:flutter/material.dart';

/// Centralised dummy data for the booking feature.
class DummyData {
  static const List<int> durations = [15, 30, 60];

  /// Generate static time slots for every day between 9:00 and 17:00 every 30 minutes.
  static List<TimeOfDay> timeSlots() {
    return List.generate(32, (i) {
      final totalMinutes = 9 * 60 + i * 15; // start 9:00
      return TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
    });
  }
}
