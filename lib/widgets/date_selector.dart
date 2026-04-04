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
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 6),
        Icon(Icons.keyboard_arrow_down, size: 20),
      ],
    );
  }
}
