import 'package:flutter/material.dart';
import 'package:flutter_main/app.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'providers/question_edit_provider.dart';
import 'providers/question_list_provider.dart';

void main() {
  initializeDateFormatting('ko_KR').then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => QuestionListProvider()),
          ChangeNotifierProvider(create: (_) => QuestionEditProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
