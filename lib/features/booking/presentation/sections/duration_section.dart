import 'package:flutter/material.dart';
import '../widgets/duration_option_chip.dart';
import '../../application/booking_controller.dart';
import 'package:provider/provider.dart';
import '../../domain/dummy_data.dart';

/// Left column showing available meeting durations and participants header.
class DurationSection extends StatelessWidget {
  const DurationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BookingController>();

    // TODO: Implement participants header and styling.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Participants (placeholder)'),
        ),
        Wrap(
          spacing: 8,
          children: DummyData.durations
              .map(
                (d) => DurationOptionChip(
                  minutes: d,
                  selected: controller.selectedDuration == d,
                  onTap: () => controller.selectDuration(d),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
