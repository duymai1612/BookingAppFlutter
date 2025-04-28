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
    '(-12:00) Baker Island Time',
    '(-11:00) Niue Time',
    '(-10:00) Hawaii-Aleutian Standard Time',
    '(-09:30) Marquesas Time',
    '(-09:00) Alaska Standard Time',
    '(-08:00) Pacific Standard Time (US & Canada)',
    '(-07:00) Mountain Standard Time (US & Canada)',
    '(-06:00) Central Standard Time (US & Canada)',
    '(-05:00) Eastern Standard Time (US & Canada)',
    '(-04:30) Venezuelan Standard Time',
    '(-04:00) Atlantic Standard Time',
    '(-03:30) Newfoundland Standard Time',
    '(-03:00) Argentina, Brazil, Uruguay',
    '(-02:00) South Georgia Time',
    '(-01:00) Azores Standard Time',
    '(+00:00) Greenwich Mean Time',
    '(+01:00) Central European Time',
    '(+02:00) Eastern European Time',
    '(+03:00) Moscow Standard Time',
    '(+03:30) Iran Standard Time',
    '(+04:00) Gulf Standard Time',
    '(+04:30) Afghanistan Time',
    '(+05:00) Pakistan Standard Time',
    '(+05:30) India Standard Time',
    '(+05:45) Nepal Time',
    '(+06:00) Bangladesh Standard Time',
    '(+06:30) Cocos Islands Time',
    '(+07:00) Indochina Time',
    '(+08:00) China Standard Time',
    '(+08:45) Australian Central Western Time',
    '(+09:00) Japan Standard Time',
    '(+09:30) Australian Central Standard Time',
    '(+10:00) Australian Eastern Standard Time',
    '(+10:30) Lord Howe Standard Time',
    '(+11:00) Solomon Island Time',
    '(+12:00) New Zealand Standard Time',
    '(+12:45) Chatham Islands Time',
    '(+13:00) Tonga Time',
    '(+14:00) Line Islands Time',
  ];
}
