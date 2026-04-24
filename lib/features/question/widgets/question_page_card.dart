import 'package:flutter/material.dart';
import 'package:flutter_main/common/gradient_dot.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../models/question.dart';
import '../../../providers/question_list_provider.dart';
import '../../../common/text_box.dart';
import '../../../common/gradient_circle.dart';

class QuestionPageCard extends StatelessWidget {
  final MapEntry<int, Question> entry;

  QuestionPageCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionListProvider>();
    final List<String> weekDayLabels = ['월', '화', '수', '목', '금', '토', '일'];
    // TODO: implement build
    return Card(
      // 중요: 자식 위젯(InkWell)의 효과가 카드 모서리에 맞춰 잘리도록 설정
      clipBehavior: Clip.antiAlias,
      elevation: 1,

      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade300, // 테두리 색
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //목표
                    children: [
                      Expanded(child: Text(entry.value.target)),
                      // 삭제버튼 아이콘
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: 20,
                          constraints: const BoxConstraints(),
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
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: const Text("목표 삭제"),
                                  content: Text(
                                    "'${entry.value.target}'정말 삭제하시겠습니까?",
                                  ),
                                  actions: [
                                    // 취소 버튼
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext),
                                      child: const Text(
                                        "취소",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    // 삭제 확정 버튼
                                    TextButton(
                                      onPressed: () {
                                        // 2. 실제 데이터 삭제 실행 (Provider 호출)
                                        provider.deleteQuestion(entry.value);

                                        // 3. 다이얼로그 닫기
                                        Navigator.pop(dialogContext);

                                        // 4. 삭제 완료 피드백 (스낵바)
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text("목표가 삭제되었습니다."),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "삭제",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(-1, 0),
                        child: TextBox(
                          condition:
                              entry.value.answerType ==
                              AnswerType.multipleChoice,
                          label_1: '객관식',
                          label_2: '주관식',
                        ),
                      ),
                      SizedBox(width: 4),
                      if (entry.value.datesIdx.length == 7)
                        TextBox(label_1: '매일', label_2: '')
                      else
                        for (var i in entry.value.dates)
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: GradientCircle(
                              //요일들 리스트
                              text: weekDayLabels[i.weekday - 1],
                              size: 20,
                              fontSize: 12,
                            ),
                          ),
                    ],
                  ),

                  if (entry.value.answerType == AnswerType.multipleChoice &&
                      entry.value.answers != [])
                    for (final option in entry.value.answers.asMap().entries)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: GradientDot(text: option.value),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
