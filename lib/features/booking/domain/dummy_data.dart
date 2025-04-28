import 'package:flutter/material.dart';

/// Centralised dummy data for the booking feature.
class DummyData {
  static const List<int> durations = [15, 30, 60];

  /// Generate static time slots for every day between 9:00 and 17:00 every 30 minutes.
  static List<TimeOfDay> timeSlots() {
    return List.generate(
        16,
        (index) =>
            TimeOfDay(hour: 9 + index ~/ 2, minute: index.isEven ? 0 : 30));
  }
}
