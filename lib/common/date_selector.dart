import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final DateTime now;

  DateSelector({
    super.key,
    required this.now,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Text(
          DateFormat('yyyy년 MM월 dd일').format(now),
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 133, 123, 123)),
        ),
        SizedBox(width: 4),
        Icon(Icons.keyboard_arrow_down, size: 20, color: const Color.fromARGB(255, 133, 123, 123)),
      ],
    );
  }
}
