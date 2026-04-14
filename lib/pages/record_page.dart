import 'package:flutter/material.dart';
import 'package:flutter_main/core/layout/base_page.dart';
import 'package:flutter_main/widgets/shadow_box.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:easy_date_timeline/easy_date_timeline.dart';

import '../models/question.dart';
import '../widgets/date_selector.dart';
import '../providers/question_list_provider.dart';
import '../widgets/calendar_dialog.dart';
import '../widgets/record_page/record_page_widgets.dart';
import '../widgets/shadow_box.dart';
import '../widgets/calendar_dialog.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  Question? selectedQuestion;
  DateTime startDate = DateTime.now().subtract(Duration(days: 31));
  DateTime endDate = DateTime.now();

  // List<Color> colorArr = [
  //     Color(0xFFFF8383),
  //     Color(0xFFFFC193),
  //     Color(0xFFFFEDCE),
  //     Color(0xFFCFECF3),
  //     Color(0xFFDAF9DE),
  //   ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int dateAnswerCounts(Question q, DateTime start, DateTime end) {
    int sum = 0;
    int i = 0;

    if (q.completedDates != null) {
      for (var date in q.completedDates) {
        print("완료:${q.completedDates}");
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
    return BasePage(
      title: '기록',
      child: SafeArea(
        child: Column(
          children: [
            // 스크롤 영역
            SingleChildScrollView(
              // padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 목표 선택 카드
                  ShadowBox(
                    widget: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          DropdownMenu<int>(
                            requestFocusOnTap: true,
                            width: double.infinity,
                            label: const Text("목표선택"),
                            hintText: "목표를 선택해주세요",
                            inputDecorationTheme: InputDecorationTheme(
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFF5B8DEF),
                                  width: 2,
                                ),
                              ),
                            ),
                            trailingIcon: const Icon(Icons.keyboard_arrow_down),
                            dropdownMenuEntries: [
                              for (var entry
                                  in provider.savedQuestions.asMap().entries)
                                DropdownMenuEntry(
                                  value: entry.key,
                                  label: entry.value.target,
                                  leadingIcon: const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Icon(Icons.assignment_outlined),
                                  ),
                                ),
                            ],
                            onSelected: (int? value) {
                              setState(() {
                                if (value != null) {
                                  selectedQuestion =
                                      provider.savedQuestions[value];
                                  if (selectedQuestion!.answersCounts.isEmpty) {
                                    selectedQuestion!.answersCounts =
                                        List.filled(
                                          selectedQuestion!.answers.length,
                                          0,
                                        );
                                  }
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 기간 선택 카드
                  ShadowBox(
                    widget: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey.shade50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '기간 선택',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                CalendarDialog.show(
                                  context,
                                  selectedDay: startDate,
                                  onDaySelected: (pickedDate) {
                                    setState(() {
                                      startDate = pickedDate;
                                    });
                                  },
                                );
                              },
                              child: DateRow(
                                date: DateFormat(
                                  'yyyy-MM-dd',
                                ).format(startDate),
                                label: '부터',
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                CalendarDialog.show(
                                  context,
                                  selectedDay: endDate,
                                  onDaySelected: (pickedDate) {
                                    setState(() {
                                      endDate = pickedDate;
                                    });
                                  },
                                );
                              },
                              child: DateRow(
                                date: DateFormat('yyyy-MM-dd').format(endDate),
                                label: '까지',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                mainAxisSpacing: 6, // 세로 아이템 간 간격 제거
                crossAxisSpacing: 6, // 가로 아이템 간 간격 제거
                crossAxisCount: 3,

                padding: EdgeInsets.zero,
                children: [
                  if (selectedQuestion != null &&
                      selectedQuestion!.answers != [])
                    for (var entry in selectedQuestion!.answers.asMap().entries)
                      
                      Container(
                        //이게 타겟이랑 횟수 카드
                        alignment: Alignment.topCenter,
                        height: 20,
                        decoration: BoxDecoration(
                          // color: ColorArr[entry.key % selectedQuestion!.answers!.length],
                          border: Border.all(
                            color: Color(0xFF5B8DEF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(entry.value),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment:
                                    Alignment.center, // 3. 0회 글자: 남은 공간의 정중앙
                                child: Text(
                                  "${dateAnswerCounts(selectedQuestion!, startDate, endDate)} 회",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
