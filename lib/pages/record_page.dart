import 'package:flutter/material.dart';
import 'package:flutter_main/core/layout/base_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math';


import '../models/question.dart';
import '../widgets/date_selector.dart';
import '../providers/question_list_provider.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late DateTime now;
  Question? selectedQuestion;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionListProvider>();

    List<Color> ColorArr = [
      Color(0xFFFF8383),
      Color(0xFFFFC193),
      Color(0xFFFFEDCE),
      Color(0xFFCFECF3),
      Color(0xFFDAF9DE),
    ];

    return BasePage(
      title: '기록',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownMenu<int>(
              //이걸 가로를 화면 넓이까지 하고싶은데 width안넣고
              // 1. 이미지처럼 너비를 꽉 채우려면 지정 (부모 크기에 맞춤)
              requestFocusOnTap: false,
              width: double.infinity,

              // 2. 초기 힌트 텍스트 및 스타일
              label: const Text("목표선택"),
              hintText: "목표를 선택해주세요",

              // 3. 테두리 및 디자인 (이미지의 파란색 테두리 느낌)
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFF5B8DEF),
                    width: 2,
                  ),
                ),
              ),

              // 4. 화살표 아이콘 변경
              trailingIcon: const Icon(Icons.keyboard_arrow_down),

              // 5. 메뉴 구성 요소
              dropdownMenuEntries: [
                for (var entry in provider.savedQuestions.asMap().entries)
                  DropdownMenuEntry(
                    value: (entry.key),
                    label: entry.value.target,
                    leadingIcon: Icon(Icons.history),
                  ),
              ],
              onSelected: (int? value) {
                setState(() {
                  if (value != null) {
                    selectedQuestion = provider.savedQuestions[value];
                    print("여기");
                    //answersCount가 완전 처음엔 null일수가 있어서 넣은거임
                    if (selectedQuestion!.answersCounts == null) {
                      selectedQuestion!.answersCounts = List.filled(
                        selectedQuestion!.answers!.length,
                        0,
                      );
                    }

                    print(selectedQuestion!.answers);
                  }
                });
              },
            ),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "기간 선택", // 테두리 사이에 들어가는 라벨
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF5B8DEF),
                      width: 2,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.start, //<<이거 왜 안먹지 start?
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: DateSelector(now: now),
                            ),
                          ),
                          Text('부터'),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: DateSelector(now: now),
                            ),
                          ),
                          Text('까지'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 6),

            Expanded(
              child: GridView.count(
                mainAxisSpacing: 6, // 세로 아이템 간 간격 제거
                crossAxisSpacing: 6, // 가로 아이템 간 간격 제거
                crossAxisCount: 3,

                padding: EdgeInsets.zero,
                children: [
                  if (selectedQuestion != null &&
                      selectedQuestion!.answers != null)
                    for (var entry
                        in selectedQuestion!.answers!.asMap().entries)
                      Container(
                        alignment: Alignment.topCenter,
                        height: 20,
                        decoration: BoxDecoration(
                          color: ColorArr[entry.key % selectedQuestion!.answers!.length], 
                          border: Border.all(
                            color: Color(0xFF5B8DEF),
                            width: 2,
                          ),
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
                                  "${selectedQuestion!.answersCounts![entry.key]} 회",
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
