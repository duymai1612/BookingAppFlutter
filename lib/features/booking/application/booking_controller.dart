import 'package:flutter/material.dart';
import '../data/event_repository.dart';
import 'dart:math';
import '../domain/dummy_data.dart';

/// Holds the booking flow state as per project rules.
class BookingController extends ChangeNotifier {
  int _selectedDuration = 15; // minutes
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedSlot;
  String _timeZone = DateTime.now().timeZoneName;

  final List<String> _participants = ['Angelo', 'Kate'];
  final EventRepository _repo = EventRepository();
  final Set<String> _disabledSlots = {}; // stores formatted time strings
  final Set<String> _unavailable =
      {}; // random unavailable time strings for selected date

  final _rng = Random();

  int get selectedDuration => _selectedDuration;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay? get selectedSlot => _selectedSlot;
  String get timeZone => _timeZone;
  List<String> get participants => List.unmodifiable(_participants);

  bool get canConfirm => _selectedSlot != null;
  bool slotDisabled(TimeOfDay slot) {
    final str = _formatTime(slot);
    return _disabledSlots.contains(str) || _unavailable.contains(str);
  }

  List<TimeOfDay> get availableSlots =>
      _unavailable.map((e) => _parseTime(e)).toList();

  BookingController() {
    _generateUnavailable();
  }

  void _generateUnavailable() {
    _unavailable.clear();
    final all = List<TimeOfDay>.from(DummyData.timeSlots())..shuffle(_rng);
    // randomly mark 6 slots unavailable
    final count = 6;
    for (var i = 0; i < count; i++) {
      _unavailable.add(_formatTime(all[i]));
    }
  }

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
      _generateUnavailable();
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
    final slotsToBlock = _selectedDuration ~/ 15; // number of 15-min slots
    for (var i = 0; i < slotsToBlock; i++) {
      final minutesFromMidnight =
          _selectedSlot!.hour * 60 + _selectedSlot!.minute + i * 15;
      final block = _formatTime(TimeOfDay(
          hour: minutesFromMidnight ~/ 60, minute: minutesFromMidnight % 60));
      _disabledSlots.add(block);
    }
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

  TimeOfDay _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split(' ')[0]);
    final isAm = parts[1].split(' ')[1] == 'AM';
    final hour24 =
        isAm ? (hour == 12 ? 0 : hour) : (hour == 12 ? 12 : hour + 12);
    return TimeOfDay(hour: hour24, minute: minute);
  }
}
