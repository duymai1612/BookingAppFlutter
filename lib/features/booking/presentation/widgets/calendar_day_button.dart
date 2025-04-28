import 'package:flutter/material.dart';

/// A clickable button representing a single day in the date picker grid.
///
/// Expected behaviour:
/// • Shows the day number (1-31) and optionally abbreviated weekday.
/// • Applies selected / disabled visual states.
/// • Calls [onTap] when pressed.
class CalendarDayButton extends StatelessWidget {
  const CalendarDayButton({
    required this.date,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final DateTime date;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement style per design and add hover effect.
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Text('${date.day}'),
      ),
    );
  }
}
