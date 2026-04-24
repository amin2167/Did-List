// widgets/common_widgets.dart

import 'package:flutter/material.dart';
import '../../../common/shadow_box.dart';

class RoundedBox extends StatelessWidget {
  final Widget child;
  const RoundedBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color:Color(0xFFF0EEFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06), // 👈 연한 그림자
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
                Icon(Icons.keyboard_arrow_down, size: 20, color: const Color.fromARGB(255, 133, 123, 123)),
                // const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
       
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}