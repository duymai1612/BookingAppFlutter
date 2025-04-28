import 'package:flutter/material.dart';

/// Animated bottom bar that appears after a time slot is selected.
///
/// Displays booking summary and confirm/cancel buttons.
/// Uses `AnimatedSwitcher` when shown/hidden.
class ConfirmationBar extends StatelessWidget {
  const ConfirmationBar({
    required this.visible,
    required this.durationMinutes,
    required this.date,
    required this.time,
    required this.onConfirm,
    required this.onCancel,
    super.key,
  });

  final bool visible;
  final int durationMinutes;
  final DateTime date;
  final TimeOfDay time;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement design layout and animation.
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: visible
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [Text('ConfirmationBar Placeholder')],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
