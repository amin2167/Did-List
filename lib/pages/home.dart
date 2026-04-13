import 'package:flutter_main/widgets/shadow_text_field.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';

import '../widgets/calendar_header.dart';
import '../core/layout/base_page.dart';
import '../models/question.dart';
import '../providers/question_list_provider.dart';
import '../widgets/complete_button.dart';

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

  //이게 달력모양 데이트 픽
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        now = picked;
      });
    }
  }

  //drops 보여줄때 날짜 비교해서 보여줄지 말지 하게하는 함수
  bool isSameDay(Question q, DateTime now) {
    Set<DateTime> dates = q.dates;
    for (var date in dates) {
      if (date.weekday == now.weekday) {
        return true;
      }
    }
    return false;
  }

  bool isComplete(Question q, DateTime now) {
    for (var date in q.completedDates) {
      if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
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
                        if (isSameDay(entry.value, now))
                          Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.grey.shade300, // 테두리 색
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF5B8DEF), // 파랑
                                              Color(0xFF8E5CF6), // 보라
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${entry.key + 1}',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            entry.value.target,
                                            softWrap: true,
                                          ),
                                        ),
                                      ),
                                      (isComplete(entry.value, now))
                                          ? Icon(
                                              Icons.task_alt,
                                              color: const Color.fromARGB(
                                                255,
                                                6,
                                                182,
                                                12,
                                              ),
                                            )
                                          : Icon(Icons.task_alt),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      //질문 타입이 객관식일경우
                                      for (var option
                                          in entry.value.answers!
                                              .asMap()
                                              .entries)
                                        if (!isComplete(entry.value, now) &&
                                            entry.value.answerType ==
                                                AnswerType
                                                    .multipleChoice) //객관식이면 선지 체크박스로 주관식이면 텍스트필드로
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  // 선택된 Set에 인덱스가 포함되어 있으면 파란색 테두리
                                                  color:
                                                      entry
                                                          .value
                                                          .selectedOptions!
                                                          .contains(option.key)
                                                      ? const Color.fromARGB(
                                                          255,
                                                          2,
                                                          134,
                                                          241,
                                                        )
                                                      : Colors.grey.shade300,
                                                  width: 2,
                                                ),
                                              ),
                                              child: CheckboxListTile(
                                                title: Text(option.value),
                                                value: entry
                                                    .value
                                                    .selectedOptions
                                                    .contains(option.key),
                                                onChanged: (bool? checked) {
                                                  setState(() {
                                                    if (checked == true) {
                                                      entry
                                                          .value
                                                          .selectedOptions
                                                          .add(option.key);
                                                    } else {
                                                      entry
                                                          .value
                                                          .selectedOptions
                                                          .remove(option.key);
                                                    }
                                                  });
                                                },
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading, // 체크박스 위치
                                                activeColor:
                                                    const Color.fromARGB(
                                                      255,
                                                      83,
                                                      151,
                                                      210,
                                                    ), // 체크됐을 때 색상
                                              ),
                                            ),
                                          ),
                                      if (entry.value.answerType ==
                                          AnswerType.subjective)
                                        TextField(
                                          controller: subjectController,
                                        ),
                                    ],
                                  ),

                                  SizedBox(height: 16),
                                  (!isComplete(entry.value, now))
                                      ? CompleteButton(
                                          label: "완료",
                                          question: entry.value,
                                          completePush: (q) {
                                            setState(() {
                                              provider.saveCounts(q);
                                              if (!q.completedDates.any(
                                                (d) =>
                                                    d.year == now.year &&
                                                    d.month == now.month &&
                                                    d.day == now.day,
                                              )) {
                                                q.completedDates.add(
                                                  DateTime(
                                                    now.year,
                                                    now.month,
                                                    now.day,
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                        )
                                      : CompleteButton(
                                          question: entry.value,
                                          label: "취소",
                                          completePush: (q) {
                                            setState(() {
                                              q.completedDates.remove(now);
                                              if (q.selectedOptions.isNotEmpty) {
                                                for (var option
                                                    in q.selectedOptions) {
                                                    --q.answersCounts[option];
                                                }
                                              }
                                            });
                                            print(entry.value.answersCounts);
                                          },
                                        ),
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

//시간버튼 누르는곳
// class TimerTile extends StatelessWidget {
//   final DateTime date;
//   final VoidCallback tap;

//   const TimerTile({super.key, required this.date, required this.tap});

//   @override
//   Widget build(BuildContext context) {
//     final formatter = DateFormat('yyyy-MM-dd');
//     final today = formatter.format(date); // "2026년 01월 15일"

//     // TODO: implement build
//     return Column(
//       children: [
//         Card(
//           clipBehavior: Clip.antiAlias,
//           margin: EdgeInsets.only(bottom: 20),
//           elevation: 1, // 그림자
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             side: BorderSide(
//               color: Colors.grey.shade300, // 테두리 색
//               width: 1,
//             ),
//           ),

//           child: InkWell(
//             onTap: () => tap(),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       gradient: LinearGradient(
//                         colors: [
//                           Color(0xFF5B8DEF), // 파랑
//                           Color(0xFF8E5CF6), // 보라
//                         ],
//                       ),
//                     ),
//                     child: Icon(
//                       Icons.calendar_today_outlined,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(today, style: TextStyle(fontSize: 15)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
