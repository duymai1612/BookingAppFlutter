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
    return ChoiceChip(
      label: Text('$minutes min'),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(.15),
      labelStyle: TextStyle(
        color: selected ? Theme.of(context).colorScheme.primary : null,
      ),
    );
  }
}
