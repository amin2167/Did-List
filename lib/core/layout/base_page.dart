import 'package:flutter/material.dart';
import 'package:flutter_main/features/record/record_page.dart';
import '../../features/home/home.dart';
import '../../features/question/question_page.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  String title;
  BasePage({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                '메뉴',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('홈'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('목표 관리'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuestionPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('기록'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecordPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: child,
      ),
    );
  }
}

// import 'package:flutter/material.dart';


// class MainHolder extends StatefulWidget {
//   Widget child;

//   MainHolder({super.key, required this.child});


//   @override
//   State<MainHolder> createState() => _MainHolderState();
// }

// class _MainHolderState extends State<MainHolder> {
//   int _selectedIndex = 0;

//   // Navigator를 통한 이동 로직
//   void _onItemTapped(int index) {
//     if (_selectedIndex == index) return; // 이미 선택된 탭이면 무시

//     setState(() {
//       _selectedIndex = index;
//     });

//     // index에 따라 다른 페이지로 이동
//     switch (index) {
//       case 0:
//         // 홈으로 이동 (기존 기록을 지우고 가고 싶다면 pushAndRemoveUntil 사용)
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage()),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const SearchPage()),
//         );
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const SettingsPage()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Body는 현재 페이지의 내용을 표시 (각 페이지가 Scaffold를 가지고 있어야 함)
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
//         ],
//         selectedItemColor: Colors.blueAccent,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//       ),
//       body: widget.child,
//     );
//   }
// }

// // 예시용 페이지 클래스들
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: const Text("홈")), body: const Center(child: Text("홈 화면")));
//   }
// }

// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: const Text("검색")), body: const Center(child: Text("검색 화면")));
//   }
// }

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: const Text("설정")), body: const Center(child: Text("설정 화면")));
//   }
// }