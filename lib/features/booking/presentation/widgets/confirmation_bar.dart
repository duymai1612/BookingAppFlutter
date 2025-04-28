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
          ? Material(
              elevation: 6,
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$durationMinutes min • ${_formatDate(context, date)} • ${time.format(context)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: onCancel, child: const Text('Cancel')),
                        const SizedBox(width: 8),
                        ElevatedButton(
                            onPressed: onConfirm, child: const Text('Confirm')),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    final l10n = MaterialLocalizations.of(context);
    return l10n.formatMediumDate(date);
  }
}
