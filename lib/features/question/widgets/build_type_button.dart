import 'package:flutter/material.dart';

class BuildTypeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BuildTypeButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      // 또는 InkWell
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50, // 버튼의 적절한 높이
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          // 1. 선택되었을 때만 파란색 보더 적용
          border: Border.all(
            color: isSelected ? Color(0xFF5B4FCF) : Colors.grey.shade300,
            width: 2.0,
          ),
          // 2. 사진처럼 부드러운 그림자 효과 (선택 시 더 강조)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.black87 : Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}