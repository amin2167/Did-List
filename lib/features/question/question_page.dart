import 'package:flutter/material.dart';
import 'package:flutter_main/common/gradient_circle.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'question_editor.dart';
import '../../models/question.dart';
import '../../providers/question_list_provider.dart';
import '../../common/text_box.dart';
import '../../common/plusAiconButton.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionListProvider>();
    final List<String> weekDayLabels = ['월', '화', '수', '목', '금', '토', '일'];
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
                          child: Card(
                            // 중요: 자식 위젯(InkWell)의 효과가 카드 모서리에 맞춰 잘리도록 설정
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
                              padding: const EdgeInsets.all(12),
                              //상단 목표
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Container(
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
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          //목표
                                          children: [
                                            Expanded(
                                              child: Text(entry.value.target),
                                            ),
                                            // 삭제버튼 아이콘
                                            IconButton(
                                              iconSize: 30,
                                              constraints:
                                                  const BoxConstraints(),
                                              icon: const Icon(
                                                FontAwesomeIcons.trashCan,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                // 1. 다이얼로그 띄우기
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext dialogContext) {
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              16,
                                                            ),
                                                      ),
                                                      title: const Text(
                                                        "목표 삭제",
                                                      ),
                                                      content: Text(
                                                        "'${entry.value.target}'정말 삭제하시겠습니까?",
                                                      ),
                                                      actions: [
                                                        // 취소 버튼
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                dialogContext,
                                                              ),
                                                          child: const Text(
                                                            "취소",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        // 삭제 확정 버튼
                                                        TextButton(
                                                          onPressed: () {
                                                            // 2. 실제 데이터 삭제 실행 (Provider 호출)
                                                            provider
                                                                .deleteQuestion(
                                                                  entry.value,
                                                                );

                                                            // 3. 다이얼로그 닫기
                                                            Navigator.pop(
                                                              dialogContext,
                                                            );

                                                            // 4. 삭제 완료 피드백 (스낵바)
                                                            ScaffoldMessenger.of(
                                                              context,
                                                            ).showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                  "목표가 삭제되었습니다.",
                                                                ),
                                                                duration:
                                                                    Duration(
                                                                      seconds:
                                                                          2,
                                                                    ),
                                                              ),
                                                            );
                                                          },
                                                          child: const Text(
                                                            "삭제",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Transform.translate(
                                              offset: Offset(-10, 0),
                                              child: TextBox(
                                                condition:
                                                    entry.value.answerType ==
                                                    AnswerType.multipleChoice,
                                                label_1: '객관식',
                                                label_2: '주관식',
                                              ),
                                            ),
                                            for (var i in entry.value.dates)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 4,
                                                ),

                                                child: GradientCircle(
                                                  text:
                                                      weekDayLabels[i.weekday -
                                                          1],
                                                  size: 20,
                                                  fontSize: 12,
                                                ),
                                              ),
                                          ],
                                        ),

                                        if (entry.value.answerType ==
                                                AnswerType.multipleChoice &&
                                            entry.value.answers != [])
                                          for (final option
                                              in entry.value.answers
                                                  .asMap()
                                                  .entries)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 2,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 6,
                                                    height: 6,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(
                                                            0xFF5B8DEF,
                                                          ), // 파랑
                                                          Color(
                                                            0xFF8E5CF6,
                                                          ), // 보라
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: Text(
                                                        option.value,
                                                        softWrap: true,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
