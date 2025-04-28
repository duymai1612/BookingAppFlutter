import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// A reusable choice chip representing one duration option (15, 30, 60 min).
///
/// Expected behaviour (to be implemented in the next step):
/// • Highlights when [selected] is true using theme colours.
/// • On tap, calls [onTap] with no arguments.
/// • Uses trailing commas & concise code style per project rules.
class DurationOptionChip extends StatelessWidget {
  const DurationOptionChip({
    required this.minutes,
    required this.selected,
    required this.onTap,
    super.key,
  });

  /// Duration in minutes that this chip represents.
  final int minutes;

  /// Whether this chip is currently selected.
  final bool selected;

  /// Callback invoked when the user taps the chip.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = selected ? AppColors.black : Colors.white;
    final borderColor = selected ? Colors.transparent : AppColors.border;
    final textColor = selected ? Colors.white : AppColors.black;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(minWidth: 120, minHeight: 40),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor),
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
            Text('$minutes min',
                style: theme.textTheme.labelMedium?.copyWith(color: textColor)),
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
    );
  }
}
