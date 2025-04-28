import 'package:flutter/material.dart';
import '../data/event_repository.dart';

/// Holds the booking flow state as per project rules.
class BookingController extends ChangeNotifier {
  int _selectedDuration = 15; // minutes
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedSlot;
  String _timeZone = DateTime.now().timeZoneName;

  final List<String> _participants = ['Angelo', 'Kate'];
  final EventRepository _repo = EventRepository();
  final Set<String> _disabledSlots = {}; // stores formatted time strings

  int get selectedDuration => _selectedDuration;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay? get selectedSlot => _selectedSlot;
  String get timeZone => _timeZone;
  List<String> get participants => List.unmodifiable(_participants);

  bool get canConfirm => _selectedSlot != null;
  bool slotDisabled(TimeOfDay slot) =>
      _disabledSlots.contains(_formatTime(slot));

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

  Future<void> confirmBooking() async {
    if (!canConfirm) return;
    final durationStr = _formatDuration(_selectedDuration);
    final dateStr =
        '${_selectedDate.year.toString().padLeft(4, '0')}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';
    final timeStr = _formatTime(_selectedSlot!);
    await _repo.createEvent(
        duration: durationStr, date: dateStr, time: timeStr);
    _disabledSlots.add(timeStr);
    _selectedSlot = null;
    notifyListeners();
  }

  String _formatDuration(int minutes) {
    if (minutes == 60) return '1 HOUR';
    if (minutes == 45) return '45 MIN';
    return '$minutes MIN';
  }

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final suffix = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $suffix';
  }
}
