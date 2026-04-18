import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/calendar_header.dart';
import '../core/layout/base_page.dart';
import '../models/question.dart';
import '../providers/question_list_provider.dart';
import '../widgets/complete_button.dart';
import '../models/state_week.dart';
import '../widgets/question_page/goal_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime now;
  Timer? _timer;
  Set<int> idxAnswers = {};
  TextEditingController subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
    now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
  }

  //   //drops클릭해서 보여줄때 날짜 비교해서 보여줄지 말지 하게하는 함수
  bool isSameDay(Question q, DateTime now) {
    for (var date in q.dates) {
      if (date.weekday == now.weekday) {
        return true;
      }
    }
    return false;
  }

  bool isNotWeekDay(Question q, DateTime now) {
    for (var date in q.dates) {
      if (date == now) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final provider = context.watch<QuestionListProvider>();

    return BasePage(
      title: '홈',
      child: Column(
        children: [
          CalendarHeader(
            date: now,
            onDateChanged: (selectedDate) {
              setState(() {
                now = selectedDate; // 부모의 상태를 업데이트
              });
            },
          ),
          SizedBox(height: 6),
          Expanded(
            child: provider.savedQuestions.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      "목표가 없습니다.\n메뉴에서 '목표 만들기'를 선택해주세요.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                : ListView(
                    children: [
                      for (var entry in provider.savedQuestions.asMap().entries)
                        if (entry.value.isAllweek
                            ? isSameDay(entry.value, now)
                            : isNotWeekDay(entry.value, now))
                          GoalCard(
                            now: now,
                            entry: entry,
                            idxAnswers: idxAnswers,
                            subjectController: subjectController,
                          ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
