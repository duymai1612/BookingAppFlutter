import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/booking_controller.dart';
import '../../domain/dummy_data.dart';
import '../widgets/time_slot_tile.dart';

/// Right column listing available time slots for selected date.
class TimeSlotsSection extends StatelessWidget {
  const TimeSlotsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BookingController>();
    final slots = DummyData.timeSlots();

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: slots.length,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final slot = slots[index];
        final isSelected = controller.selectedSlot == slot;
        return TimeSlotTile(
          timeOfDay: slot,
          selected: isSelected,
          onTap: () => controller.selectSlot(slot),
        );
      },
    );
  }
}
