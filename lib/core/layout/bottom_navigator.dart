// bottom_navigator.dart
import 'package:flutter/material.dart';
import '../../features/home/home.dart';
import '../../features/question/question_page.dart';
import '../../features/record/record_page.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 0;

  final List<String> _titles = ['홈', '목표 관리', '기록'];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [MyHomePage(), QuestionPage(), RecordPage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // toolbarHeight: 40,
      //   centerTitle: true,
      //   title: Text(
      //     _titles[_currentIndex],
      //     style: const TextStyle(fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: _pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '목표 설정'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '기록'),
        ],
      ),
    );
  }
}
