import 'package:flutter/material.dart';
import '../widgets/duration_option_chip.dart';
import '../../application/booking_controller.dart';
import 'package:provider/provider.dart';
import '../../domain/dummy_data.dart';
import '../../../../core/theme/app_colors.dart';

/// Left column showing available meeting durations and participants header.
class DurationSection extends StatelessWidget {
  const DurationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BookingController>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ParticipantsHeader(),
          const SizedBox(height: 24),
          Text('1. DURATION',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Column(
            children: DummyData.durations
                .map(
                  (d) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DurationOptionChip(
                      minutes: d,
                      selected: controller.selectedDuration == d,
                      onTap: () => controller.selectDuration(d),
                    ),
                  ),
                )
                .toList(),
          ),
          const Spacer(),
          _TimezoneFooter(),
        ],
      ),
    );
  }
}

class _ParticipantsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dummy circular avatar placeholders
        _AvatarPlaceholder(),
        const SizedBox(width: 8),
        _AvatarPlaceholder(),
        const Spacer(),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 16),
          label: const Text('ADD MORE'),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8)),
        ),
      ],
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: AppColors.bulletGrey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _TimezoneFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timezoneString = DateTime.now().timeZoneName;
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text('($timezoneString) • Local Time',
          style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
