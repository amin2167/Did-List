import 'package:flutter/material.dart';

class PlusAiconButton extends StatelessWidget {
  final Widget page;
  final String label;
  final  width;

  const PlusAiconButton({
    super.key, 
    required this.page,
    required this.label,
    this.width = 40,
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
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8E5CF6),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        label: Text(style: TextStyle(color: Colors.white), label),
        icon: const Icon(Icons.add, color: Colors.white),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
