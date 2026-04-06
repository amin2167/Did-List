import 'package:flutter/material.dart';
import 'package:flutter_main/core/layout/base_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionListProvider>();
    Question selectedQuestion;
    // TODO: implement build
    return BasePage(
      title: '기록',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownMenu<String>( //이걸 가로를 화면 넓이까지 하고싶은데 width안넣고
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
              //이거 왜 for에 빨간줄? 나는 DropdownMenuEntry위젯을 for 돌리고싶은걷임
             
          
              // 5. 메뉴 구성 요소
              dropdownMenuEntries: [
                 for(var entry in provider.savedQuestions.asMap().entries)
                  DropdownMenuEntry(
                    value: (entry.key+1).toString(),
                    label: entry.value.target,
                    leadingIcon: Icon(Icons.history),
                  ),
              ],
              onSelected: (String? value) {
                //selectedQuestion = entry.value; //이거 선택된걸 어떻게 가져오지..
                print("선택된 값: $value");
              },
            ),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xFF5B8DEF)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                        ],
                      ),
              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
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
            SizedBox(height: 6,),
            Expanded(
              child: ListView(
                children: [
                  for(var entry in provider.savedQuestions.asMap().entries)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            
                            alignment: Alignment.topCenter,
                            height: 50,
                            // width:  MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Column(
                              children: [
                                // Text('${entry.value.}'),
                                Text('2회')
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Column(
                              children: [
                                Text('test2'),
                                Text('회')
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
