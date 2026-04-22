import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final bool condition;
  final String label_1; 
  final String? label_2;

  const TextBox({
    super.key,
    required this.label_1,
    this.label_2,
    this.condition = true,
   });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      width: 50,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          condition ? '객관식' : '주관식',
          style: TextStyle(
            fontSize: 12,
            color: const Color.fromARGB(255, 119, 76, 197),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
