import 'package:flutter/material.dart';

/// Root page hosting the three-column booking layout.
/// Currently contains placeholder widgets – slots, date picker and duration list
/// will be implemented in subsequent steps once structure is approved.
class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO(duration column)
            Expanded(
              child: Container(
                color: Colors.blue.shade50,
                alignment: Alignment.topCenter,
                child: const Text('Duration Column Placeholder'),
              ),
            ),
            // TODO(date picker column)
            Expanded(
              child: Container(
                color: Colors.green.shade50,
                alignment: Alignment.topCenter,
                child: const Text('Date Picker Column Placeholder'),
              ),
            ),
            // TODO(time slots column)
            Expanded(
              child: Container(
                color: Colors.orange.shade50,
                alignment: Alignment.topCenter,
                child: const Text('Time Slots Column Placeholder'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
