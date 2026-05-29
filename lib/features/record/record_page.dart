import 'package:flutter/material.dart';
import 'package:flutter_main/core/layout/base_page.dart';
import 'package:flutter_main/features/record/widgets/record_card_multiple.dart';
import 'package:flutter_main/common/shadow_box.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:easy_date_timeline/easy_date_timeline.dart';

import '../../models/question.dart';
import '../../common/date_selector.dart';
import '../../providers/question_list_provider.dart';
import '../../calendar/calendar_dialog.dart';
import 'widgets/record_page_widgets.dart';
import '../../common/shadow_box.dart';
import '../../calendar/calendar_dialog.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  Question? selectedQuestion;
  // DateTime startDate = DateTime.now().subtract(Duration(days: 31));
  // DateTime endDate = DateTime.now().add(Duration(days: 7));
  DateTime? startDate;
  DateTime? endDate;
  late Duration duration;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //duration = endDate.difference(startDate);
  }

  int dateAnswerCounts(Question q, DateTime start, DateTime end) {
    int sum = 0;
    int i = 0;

    if (q.completedDates != null) {
      for (var date in q.completedDates) {
        if (!date.isBefore(start) && !date.isAfter(end)) {
          sum += q.answersCounts[i];
        }
        i++;
      }
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionListProvider>();

    // final selectedDuration = (startDate != null && endDate != null)
    //     ? endDate!.difference(startDate!)
    //     : null;

    return SafeArea(
      child: Column(
        children: [
          Center(
            child: const Text(
              "기록",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // 스크롤 영역
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
          
              // 기간 선택 카드
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05), // 아주 연한 그림자
                      blurRadius: 10,
                      offset: const Offset(0, 2), // 아래쪽으로 살짝 내려온 그림자
                    ),
                  ],
                ),
          
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '기간 선택',
                        style: TextStyle(
                          color: Color.fromARGB(255, 139, 133, 133),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
          
                      Row(
                        children: [
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    CalendarDialog.show(
                                      context,
                                      selectedDay: startDate ?? DateTime.now(),
                                      onDaySelected: (pickedDate) {
                                        setState(() {
                                          startDate = pickedDate;
                                          //duration = endDate.difference(startDate);
                                        });
                                      },
                                    );
                                  },
                                  child: DateRow(
                                    date: startDate != null
                                        ? DateFormat('yyyy-MM-dd').format(startDate!)
                                        : '시작일 선택',  // 비어있을 때 placeholder
                                    label: '',
                                  ),
                                );
                              }
                            ),
                          ),
                          Center(child: Text("~  ")),
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    CalendarDialog.show(
                                      context,
                                      selectedDay: endDate ?? DateTime.now(),
                                      onDaySelected: (pickedDate) {
                                        setState(() {
                                          endDate = pickedDate;
                                          //duration = endDate.difference(startDate);
                                        });
                                      },
                                    );
                                  },
                                  child: DateRow(
                                    date: endDate != null
                                        ? DateFormat('yyyy-MM-dd').format(endDate!)
                                        : '종료일 선택',  // 비어있을 때 placeholder
                                    label: '',
                                  ),
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
          Expanded(
            child: ListView(
              // mainAxisSpacing: 6, // 세로 아이템 간 간격 제거
              // crossAxisSpacing: 6, // 가로 아이템 간 간격 제거
              // crossAxisCount: 3,
      
              padding: EdgeInsets.zero,
              children: [
                // if (provider.savedQuestions != null)
                  for (var entry in provider.savedQuestions.asMap().entries)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: RecordMultipleCard(
                        entry: entry,
                        duration: DateTime.now().difference(entry.value.startDate) + Duration(days: 1),
                      ),
                    ),
                SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
