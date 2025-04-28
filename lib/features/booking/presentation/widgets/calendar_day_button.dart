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
    final theme = Theme.of(context);
    final bgColor =
        selected ? theme.colorScheme.primary.withOpacity(.15) : null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          '${date.day}',
          style: TextStyle(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? theme.colorScheme.primary : null,
          ),
        ),
      ),
    );
  }
}
