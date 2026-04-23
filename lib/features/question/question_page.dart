import 'package:flutter/material.dart';
import 'package:flutter_main/common/gradient_circle.dart';
import 'package:flutter_main/features/question/widgets/question_page_card.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'question_editor.dart';
import '../../models/question.dart';
import '../../providers/question_list_provider.dart';
import '../../common/text_box.dart';
import '../../common/plusAiconButton.dart';
import '../../common/text_box.dart';
import '../question/widgets/question_page_card.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionListProvider>();
    
    //페이지 메인
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 영역 (제목 + 버튼)
          Center(
            child: const Text(
              "리스트",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // 2. 우측에 위치할 버튼
          Align(
            alignment: Alignment.centerRight,
            child: PlusAiconButton(page: AddQuestionPage(), label: '새 목표'),
          ),

          SizedBox(height: 4),
          // 내용 영역
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
                        Text('아직 추가된 목표가 없습니다.', textAlign: TextAlign.center),
                      ],
                    ),
                  )
                : ListView(
                    children: [
                      for (final entry
                          in provider.savedQuestions.asMap().entries)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AddQuestionPage(nowQuestion: entry.value),
                              ),
                            );
                          },
                          child: QuestionPageCard(entry: entry),
                        ), //여기임
                      // 오른쪽 아이콘
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
