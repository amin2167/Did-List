import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color textColor;
  final IconData? icon;
  
  DeleteButton({
    super.key,
    required this.label,
    required this.onTap,
    // Color color = Colors.white, // 기본값 흰색
    required this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Widget buttonContent = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.red,
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
