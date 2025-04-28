import 'package:flutter/material.dart';

/// Holds the booking flow state as per project rules.
class BookingController extends ChangeNotifier {
  int _selectedDuration = 15; // minutes
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedSlot;
  String _timeZone = DateTime.now().timeZoneName;

  final List<String> _participants = ['Angelo', 'Kate'];

  int get selectedDuration => _selectedDuration;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay? get selectedSlot => _selectedSlot;
  String get timeZone => _timeZone;
  List<String> get participants => List.unmodifiable(_participants);

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

  void selectTimeZone(String tz) {
    if (tz != _timeZone) {
      _timeZone = tz;
      notifyListeners();
    }
  }

  void addParticipant(String name) {
    _participants.add(name);
    notifyListeners();
  }

  static bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Add [months] (can be negative) to currently selected month while respecting
  /// constraint: no earlier than current month and no more than 3 months ahead.
  void shiftMonth(int months) {
    final firstOfCurrent = DateTime(DateTime.now().year, DateTime.now().month);
    final firstAllowed = firstOfCurrent;
    final lastAllowed = DateTime(firstOfCurrent.year, firstOfCurrent.month + 3);

    final candidate =
        DateTime(_selectedDate.year, _selectedDate.month + months);

    if (candidate.isBefore(firstAllowed) || candidate.isAfter(lastAllowed))
      return;

    _selectedDate = DateTime(candidate.year, candidate.month, 1);
    _selectedSlot = null; // Reset slot when month changes.
    notifyListeners();
  }
}
