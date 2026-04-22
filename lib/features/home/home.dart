import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../calendar/calendar_header.dart';
import '../../core/layout/base_page.dart';
import '../../models/question.dart';
import '../../providers/question_list_provider.dart';
import '../../common/complete_button.dart';
import '../../models/state_week.dart';
import '../question/widgets/goal_card.dart';

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

    return Column(
      children: [
        Material(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    "홈",
                  ),
                ),
                CalendarHeader(
                  date: now,
                  onDateChanged: (selectedDate) {
                    setState(() {
                      now = selectedDate; // 부모의 상태를 업데이트
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 6),
        Expanded(
          child: provider.savedQuestions.isEmpty
              ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEF8), // 연보라 배경
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.track_changes, // 동심원 모양
                        size: 44,
                        color: Color(0xFF5B4FCF), // 보라색
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "목표가 없습니다.\n 새 목표를 만들어 주세요.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
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
    );
  }
}
