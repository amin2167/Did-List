import 'package:flutter/material.dart';
import 'package:flutter_main/pages/home.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: '일기장',
        // theme: ThemeData(), // 복사한 클래스의 light 테마 적용
        // themeMode: ThemeMode.system,
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}
