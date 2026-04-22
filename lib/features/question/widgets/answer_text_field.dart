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
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              // ← 이거 추가
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
