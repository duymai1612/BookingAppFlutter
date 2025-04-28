import 'package:flutter/material.dart';

/// Holds the booking flow state as per project rules.
class BookingController extends ChangeNotifier {
  int _selectedDuration = 15; // minutes
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedSlot;

  int get selectedDuration => _selectedDuration;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay? get selectedSlot => _selectedSlot;

  bool get canConfirm => _selectedSlot != null;

  void selectDuration(int minutes) {
    if (minutes != _selectedDuration) {
      _selectedDuration = minutes;
      notifyListeners();
    }
  }

  void selectDate(DateTime date) {
    if (!isSameDate(date, _selectedDate)) {
      _selectedDate = date;
      // Clear slot when date changes.
      _selectedSlot = null;
      notifyListeners();
    }
  }

  void selectSlot(TimeOfDay slot) {
    if (slot != _selectedSlot) {
      _selectedSlot = slot;
      notifyListeners();
    }
  }

  void cancelSelection() {
    _selectedSlot = null;
    notifyListeners();
  }

  static bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
