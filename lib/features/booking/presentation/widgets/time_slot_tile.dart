import 'package:flutter/material.dart';

/// List tile representing an available time slot for a given day.
///
/// Expected behaviour:
/// • Shows human-readable time (e.g., 10:30 AM).
/// • Highlights when [selected] is true.
/// • Calls [onTap] to select.
class TimeSlotTile extends StatelessWidget {
  const TimeSlotTile({
    required this.timeOfDay,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final TimeOfDay timeOfDay;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with ListTile themed per design.
    return ListTile(
      title: Text(timeOfDay.format(context)),
      selected: selected,
      onTap: onTap,
    );
  }
}
