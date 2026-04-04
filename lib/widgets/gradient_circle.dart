import 'package:flutter/material.dart';

class GradientCircle extends StatelessWidget {
  final double size;
  final String text;
  final double fontSize;

  const GradientCircle({
    super.key,
    this.size = 30,
    required this.text,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFF5B8DEF),
            Color(0xFF8E5CF6),
          ],
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}