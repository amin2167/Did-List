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
        color: Color.fromARGB(255, 220, 216, 245),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: const Color.fromARGB(255, 76, 76, 197),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}