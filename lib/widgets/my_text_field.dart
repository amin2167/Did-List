import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final int height;

  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      minLines: height, // 👈 이 한 줄이 핵심
      maxLines: height,
      controller: controller,
      style: TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        //filled: true,
        // fillColor: const Color.fromARGB(255, 161, 218, 244),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}
