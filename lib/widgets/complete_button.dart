import 'package:flutter/material.dart';

import '../models/question.dart';

class CompleteButton extends StatelessWidget {
  final String label;
  final Question question;
  final Function(Question) completePush;

  const CompleteButton({
    super.key,
    required this.question,
    required this.label,
    required this.completePush,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [

            Color(0xFF5B8DEF), // 파랑
            Color(0xFF8E5CF6), // 보라
          ],
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          completePush(question);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
