import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../application/booking_controller.dart';

class ParticipantsBar extends StatelessWidget {
  const ParticipantsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BookingController>();
    final participants = controller.participants;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ...participants.map((p) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(_avatarFor(p)),
                  backgroundColor: AppColors.bulletGrey,
                  child: Text(
                    p.substring(0, 1).toUpperCase(),
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              )),
          const Spacer(),
          TextButton.icon(
            onPressed: () => _showAddDialog(context),
            icon: const Icon(Icons.add, size: 16, color: AppColors.green),
            label: const Text('ADD MORE'),
          ),
        ],
      ),
    );
  }

  static String _avatarFor(String name) {
    // Simple robohash placeholder avatar
    return 'https://robohash.org/$name.png?size=50x50';
  }

  void _showAddDialog(BuildContext context) {
    final controller = context.read<BookingController>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Participant'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = textController.text.trim();
              if (name.isNotEmpty) {
                controller.addParticipant(name);
              }
              Navigator.of(ctx).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
