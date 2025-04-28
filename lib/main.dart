import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/booking/presentation/pages/booking_page.dart';

void main() {
  runApp(const BookingApp());
}

class BookingApp extends StatelessWidget {
  const BookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const BookingPage(),
    );
  }
}
