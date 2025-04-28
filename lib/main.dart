import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/booking/presentation/pages/booking_page.dart';
import 'package:provider/provider.dart';
import 'features/booking/application/booking_controller.dart';

void main() {
  runApp(const BookingApp());
}

class BookingApp extends StatelessWidget {
  const BookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingController(),
      child: MaterialApp(
        title: 'Booking App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const BookingPage(),
      ),
    );
  }
}
