// app.dart
import 'package:flutter/material.dart';
import 'core/layout/bottom_navigator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '했음 리스트',
      home: BottomNavigator(),
    );
  }
}