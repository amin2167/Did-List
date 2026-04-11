import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_main/pages/question_editor.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';

import '../widgets/date_selector.dart';
import '../core/layout/base_page.dart';
import '../models/question.dart';
import '../providers/question_list_provider.dart';
import '../widgets/plusAiconButton.dart';
import '../widgets/calendar_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime now;
  Timer? _timer;
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  Set<int> idxAnswers = {};

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
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

  bool isComplete (Question q, DateTime now) {
    for (var date in q.completedDates) {
      if (date.year == now.year && date.month == now.month && date.day == now.day) {
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
          EasyInfiniteDateTimeLine(
            locale: 'ko',
            controller: _controller,
            firstDate: DateTime(2024),
            focusDate: now, // 현재 선택된 날짜
            lastDate: DateTime(2026, 12, 31),
            onDateChange: (selectedDate) {
              setState(() {
                now = selectedDate;
              });
            },
            headerBuilder: (context, data) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // 네모난 큰 달력 나오게 하는거
                  CalendarDialog.show(
                    context,
                    selectedDay: now, // 현재 home.dart가 가지고 있는 선택된 날짜
                    onDaySelected: (pickedDate) {
                      // 다이얼로그에서 날짜를 찍었을 때 실행될 로직
                      setState(() {
                        now = pickedDate;
                      });
                      _controller.animateToDate(pickedDate);
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //아래 화살표 잇는 날짜 바꾸려고 하는 버튼
                      DateSelector(now: now),
                      PlusAiconButton(
                        page: const AddQuestionPage(),
                        label: '새 목표',
                      ),
                    ],
                  ),
                ),
              );
            },

            dayProps: EasyDayProps(
              height: MediaQuery.of(context).size.height * 0.08,
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF5B8DEF), Color(0xFF8E5CF6)],
                  ),
                ),
              ),
            ),
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
                        if(isSameDay(entry.value, now) && !isComplete(entry.value, now))
                          Card(
                            //완료 버튼 누르면 이 카드가 없어졋다가 다시 다음주에 나와야대면 또 나와야대는데 여기에 어캐 접근하지;
                            clipBehavior: Clip.antiAlias,
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(entry.value.target),
                                      ),
                                      Icon(Icons.task_alt),
                                    ],
                                  ),
                                  // SizedBox(height: 4),
                                  entry.value.answerType ==
                                          AnswerType.multipleChoice
                                      ? Column(
                                          children: [
                                            for (var option
                                                in entry.value.answers!
                                                    .asMap()
                                                    .entries)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                    ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    border: Border.all(
                                                      // 선택된 Set에 인덱스가 포함되어 있으면 파란색 테두리
                                                      color:
                                                          entry
                                                              .value
                                                              .selectedOptions!
                                                              .contains(
                                                                option.key,
                                                              )
                                                          ? const Color.fromARGB(
                                                              255,
                                                              2,
                                                              134,
                                                              241,
                                                            )
                                                          : Colors
                                                                .grey
                                                                .shade300,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: CheckboxListTile(
                                                    title: Text(option.value),
                                                    value: entry
                                                        .value
                                                        .selectedOptions!
                                                        .contains(option.key),
                                                    onChanged: (bool? checked) {
                                                      setState(() {
                                                        if (checked == true) {
                                                          entry
                                                              .value
                                                              .selectedOptions!
                                                              .add(option.key);
                                                        } else {
                                                          entry
                                                              .value
                                                              .selectedOptions!
                                                              .remove(
                                                                option.key,
                                                              );
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
                                          ],
                                        )
                                      : TextField(),

                                  SizedBox(height: 14),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF5B8DEF), // 파랑
                                          Color(0xFF8E5CF6), // 보라
                                        ],
                                      ),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),

                                      onPressed: () {
                                        setState(() {
                                          provider.saveCounts(entry.value);
                                          if (!entry.value.completedDates.any(
                                            (d) =>
                                                d.year == now.year &&
                                                d.month == now.month &&
                                                d.day == now.day,
                                          )) {
                                            entry.value.completedDates.add(now);
                                          }
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.task_alt,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "완료",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
class TimerTile extends StatelessWidget {
  final DateTime date;
  final VoidCallback tap;

  const TimerTile({super.key, required this.date, required this.tap});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd');
    final today = formatter.format(date); // "2026년 01월 15일"

    // TODO: implement build
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(bottom: 20),
          elevation: 1, // 그림자
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Colors.grey.shade300, // 테두리 색
              width: 1,
            ),
          ),

          child: InkWell(
            onTap: () => tap(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF5B8DEF), // 파랑
                          Color(0xFF8E5CF6), // 보라
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(today, style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
