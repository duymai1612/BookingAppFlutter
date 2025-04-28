import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../application/booking_controller.dart';

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
    final isToday = BookingController.isSameDate(date, DateTime.now());
    final bgColor = selected ? AppColors.black : Colors.transparent;
    final textColor = selected ? Colors.white : AppColors.black;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.all(2),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isToday ? AppColors.green : Colors.transparent,
              width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text('${date.day}',
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
