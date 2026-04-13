// widgets/common_widgets.dart

import 'package:flutter/material.dart';
import '../shadow_box.dart';

class RoundedBox extends StatelessWidget {
  final Widget child;
  const RoundedBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF5B8DEF),
        ),
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

class DateRow extends StatelessWidget {
  final String date;
  final String label;
  const DateRow({super.key, required this.date, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_today_outlined, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: RoundedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date),
                const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}