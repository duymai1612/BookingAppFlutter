import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/booking_controller.dart';
import '../widgets/calendar_day_button.dart';

/// Middle column with month navigation and day grid.
class DatePickerSection extends StatelessWidget {
  const DatePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BookingController>();
    final selectedDate = controller.selectedDate;
    final daysInMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0).day;

    // Build list of DateTime for the month.
    final days = List.generate(daysInMonth,
        (i) => DateTime(selectedDate.year, selectedDate.month, i + 1));

    return Column(
      children: [
        _MonthHeader(
            date: selectedDate,
            onPrev: () => controller.shiftMonth(-1),
            onNext: () => controller.shiftMonth(1)),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, mainAxisExtent: 40),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final date = days[index];
              return CalendarDayButton(
                date: date,
                selected: BookingController.isSameDate(date, selectedDate),
                onTap: () => controller.selectDate(date),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader(
      {required this.date, required this.onPrev, required this.onNext});

  final DateTime date;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final monthLabel = '${_monthName(date.month)} ${date.year}';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: const Icon(Icons.chevron_left), onPressed: onPrev),
        Text(monthLabel, style: Theme.of(context).textTheme.titleMedium),
        IconButton(icon: const Icon(Icons.chevron_right), onPressed: onNext),
      ],
    );
  }

  String _monthName(int m) => const [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ][m - 1];
}
