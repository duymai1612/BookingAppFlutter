import 'package:flutter/material.dart';

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
    // TODO: Replace Container with ChoiceChip implementation.
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
        color: selected ? Colors.greenAccent : Colors.transparent,
      ),
      child: Text('$minutes min'),
    );
  }
}
