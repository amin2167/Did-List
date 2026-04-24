import 'package:flutter/material.dart';

class GradientDot extends StatelessWidget {
  String text;

  GradientDot({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFF5B8DEF), // 파랑
                Color(0xFF8E5CF6), // 보라
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(text, softWrap: true),
        ),
      ],
    );
  }
}
