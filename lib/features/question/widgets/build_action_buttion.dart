import 'package:flutter/material.dart';

class BuildActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color textColor = Colors.black87;
  final IconData? icon;

  BuildActionButton({
    super.key,
    required this.label,
    required this.onTap,
    // Color color = Colors.white, // 기본값 흰색
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Widget buttonContent = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF5B8DEF), // 파랑
            Color(0xFF8E5CF6), // 보라
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 20),
              const SizedBox(width: 8),
            ],
            Icon(Icons.save_outlined, color: Colors.white),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

    // TODO: implement build
    return Expanded(
      child: InkWell(onTap: onTap, child: buttonContent),
    );
  }
}
