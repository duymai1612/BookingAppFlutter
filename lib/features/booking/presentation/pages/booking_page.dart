import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/booking_controller.dart';
import '../sections/duration_section.dart';
import '../sections/date_picker_section.dart';
import '../sections/time_slots_section.dart';
import '../widgets/confirmation_bar.dart';
import 'package:booking_app_flutter/core/theme/app_colors.dart';
import '../widgets/participants_bar.dart';
import '../widgets/steps_header.dart';

/// Root page hosting the three-column booking layout.
/// Currently contains placeholder widgets – slots, date picker and duration list
/// will be implemented in subsequent steps once structure is approved.
class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ParticipantsBar(),
            const StepsHeader(),
            Expanded(
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(child: DurationSection()),
                      VerticalDivider(width: 1, color: AppColors.border),
                      Expanded(child: DatePickerSection()),
                      VerticalDivider(width: 1, color: AppColors.border),
                      Expanded(child: TimeSlotsSection()),
                    ],
                  ),
                  const Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: _ConfirmationOverlay(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Private overlay widget to consume BookingController and render ConfirmationBar.
class _ConfirmationOverlay extends StatelessWidget {
  const _ConfirmationOverlay();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BookingController>();
    return Align(
      alignment: Alignment.bottomRight,
      child: ConfirmationBar(
        visible: controller.canConfirm,
        durationMinutes: controller.selectedDuration,
        date: controller.selectedDate,
        time: controller.selectedSlot ?? const TimeOfDay(hour: 0, minute: 0),
        onConfirm: () {
          // TODO: implement confirm action (show snackbar for now)
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Booking confirmed (stub)')));
        },
        onCancel: controller.cancelSelection,
      ),
    );
  }
}
