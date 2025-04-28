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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: visible
          ? Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 360),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('4. CONFIRM BOOKING',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Text(
                      '$durationMinutes minute meeting on ${_formatDate(context, date)} at ${time.format(context)}',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: onCancel, child: const Text('Cancel')),
                        const SizedBox(width: 12),
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
