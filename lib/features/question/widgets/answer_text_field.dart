import 'package:flutter/material.dart';
import '../../../common/shadow_box.dart';

// AnswerTextField는 그대로
class AnswerTextField extends StatelessWidget {
  const AnswerTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // width: MediaQuery.of(context).size.width * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true, // 👈 필수
            fillColor: Colors.white, // 👈 배경색
            hintText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF5B4FCF), width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
