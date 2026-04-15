// import 'package:flutter/material.dart';
// import 'package:flutter_main/app.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/date_symbol_data_local.dart';

// import 'providers/question_edit_provider.dart';
// import 'providers/question_list_provider.dart';

// void main() {
//   initializeDateFormatting('ko_KR').then(
//     (_) => runApp(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (_) => QuestionListProvider()),
//           ChangeNotifierProvider(create: (_) => QuestionEditProvider()),
//         ],
//         child: const MyApp(),
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:flutter_main/app.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hive_flutter/hive_flutter.dart';
 
import 'models/question.dart';
import 'providers/question_edit_provider.dart';
import 'providers/question_list_provider.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  // Hive 초기화
  await Hive.initFlutter();
  Hive.registerAdapter(QuestionAdapter()); // question.g.dart에서 생성된 어댑터
 
  final questionListProvider = QuestionListProvider();
  await questionListProvider.init(); // Hive에서 데이터 불러오기
 
  initializeDateFormatting('ko_KR').then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => questionListProvider),
          ChangeNotifierProvider(create: (_) => QuestionEditProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
 