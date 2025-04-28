import 'package:flutter/material.dart';

class StepsHeader extends StatelessWidget {
  const StepsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(child: Center(child: Text('1. DURATION', style: style))),
          Expanded(child: Center(child: Text('2. DATE', style: style))),
          Expanded(child: Center(child: Text('3. TIME', style: style))),
        ],
      ),
    );
  }
}
