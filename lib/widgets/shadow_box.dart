import 'package:flutter/material.dart';

//이거 아직 안쓰는중임 2026-03-25
class ShadowBox extends StatelessWidget {
  Widget widget;

  ShadowBox({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // 아주 연한 그림자
            blurRadius: 10,
            offset: const Offset(0, 4), // 아래쪽으로 살짝 내려온 그림자
          ),
        ],
      ),
      child: widget,
    );
  }
}