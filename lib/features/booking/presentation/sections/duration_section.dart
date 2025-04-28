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
    final controller = context.watch<BookingController>();
    final currentTz = controller.timeZone;

    // Merge and deduplicate items
    final items = <String>{..._timeZones}.toList();

    // Find a label that contains the abbreviation if possible
    String selectedLabel = items.firstWhere(
      (e) => e.contains(currentTz),
      orElse: () => items.first,
    );

    // Ensure controller holds full label, not abbrev
    if (selectedLabel != controller.timeZone) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.selectTimeZone(selectedLabel);
      });
    }

    return Center(
      child: DropdownButtonHideUnderline(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButton<String>(
            value: selectedLabel,
            isDense: true,
            dropdownColor: Colors.white,
            menuMaxHeight: 300,
            items: items
                .map(
                  (tz) => DropdownMenuItem(
                    value: tz,
                    child: Text(tz, overflow: TextOverflow.ellipsis),
                  ),
                )
                .toList(),
            onChanged: (val) => controller.selectTimeZone(val!),
            icon:
                const Icon(Icons.expand_more, size: 14, color: AppColors.black),
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColors.black),
          ),
        ),
      ),
    );
  }

  static const List<String> _timeZones = [
    '(-12:00) UTC-12',
    '(-11:00) UTC-11',
    '(-10:00) HST - Hawaii',
    '(-09:00) AKST - Alaska',
    '(-08:00) PST - Pacific Time',
    '(-07:00) MST - Mountain Time',
    '(-06:00) CST - Central Time',
    '(-05:00) EST - New York Time',
    '(-04:00) AST - Atlantic',
    '(-03:00) BRT - Brazil',
    '(-02:00) UTC-02',
    '(-01:00) Azores',
    '(+00:00) GMT',
    '(+01:00) CET - Central Europe',
    '(+02:00) EET - Eastern Europe',
    '(+03:00) MSK - Moscow',
    '(+05:30) IST - India',
    '(+07:00) ICT - Indochina',
    '(+08:00) CST - China',
    '(+09:00) JST - Japan',
    '(+10:00) AEST - Australia',
    '(+12:00) NZST - New Zealand',
  ];
}
