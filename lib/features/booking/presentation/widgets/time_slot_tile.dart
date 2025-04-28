import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../application/booking_controller.dart';
import 'package:provider/provider.dart';

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
    final controller = context.read<BookingController>();
    final disabled = controller.slotDisabled(timeOfDay);
    final label = timeOfDay.format(context);
    final bgColor = selected ? AppColors.black : Colors.white;
    final textColor = selected ? Colors.white : AppColors.black;

    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Opacity(
        opacity: disabled ? 0.4 : 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: textColor)),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: selected ? AppColors.green : Colors.transparent,
                  border: Border.all(color: AppColors.bulletGrey, width: 1.5),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
