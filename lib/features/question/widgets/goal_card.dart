import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../calendar/calendar_header.dart';
import '../../../core/layout/base_page.dart';
import '../../../models/question.dart';
import '../../../providers/question_list_provider.dart';
import '../../../common/complete_button.dart';
import '../../../common/my_text_field.dart';

class GoalCard extends StatefulWidget {
  GoalCard({
    super.key,
    required this.now,
    required this.entry,
    required this.idxAnswers,
    required this.subjectController,
  });
  late DateTime now;
  MapEntry<int, Question> entry;
  Set<int> idxAnswers = {};
  final TextEditingController subjectController;

  @override
  State<GoalCard> createState() => _GoalCard();
}

class _GoalCard extends State<GoalCard> {
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

  void saveCounts(Question q) {
    q.answersCounts = List.filled(q.answers.length, 0);

    if (q.selectedOptions.isNotEmpty) {
      for (var k in q.selectedOptions) {
        q.answersCounts[k]++;
      }
    }
  }

  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
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
                      '${widget.entry.key + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.entry.value.target, softWrap: true),
                ),
                (isComplete(widget.entry.value, widget.now))
                    ? Icon(
                        Icons.task_alt,
                        color: const Color.fromARGB(255, 6, 182, 12),
                      )
                    : Icon(Icons.task_alt),
              ],
            ),
            Column(
              children: [
                //질문 타입이 객관식일경우
                for (var option in widget.entry.value.answers.asMap().entries)
                  if (!isComplete(widget.entry.value, widget.now))
                     
                  //객관식이면 선지 체크박스로 주관식이면 텍스트필드로
                  if (widget.entry.value.answerType == AnswerType.multipleChoice)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            //체크박스 파란색 대는 부분
                            color:
                                widget.entry.value.selectedOptions.contains(
                                  option.key,
                                )
                                ? const Color.fromARGB(255, 2, 134, 241)
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: CheckboxListTile(
                          title: Text(option.value),
                          value: widget.entry.value.selectedOptions.contains(
                            option.key,
                          ),
                          onChanged: (bool? checked) {
                            setState(() {
                              if (checked == true) {
                                widget.entry.value.selectedOptions.add(
                                  option.key,
                                );
                              } else {
                                widget.entry.value.selectedOptions.remove(
                                  option.key,
                                );
                              }
                              widget.entry.value.save(); // Hive 저장
                            });
                          },
                          controlAffinity:
                              ListTileControlAffinity.leading, // 체크박스 위치
                          activeColor: const Color.fromARGB(
                            255,
                            83,
                            151,
                            210,
                          ), // 체크됐을 때 색상
                        ),
                      ),
                    ),
                if (widget.entry.value.answerType == AnswerType.subjective)
                  if(!isComplete(widget.entry.value, widget.now))
                    MyTextField(
                      controller: widget.subjectController,
                      label: '답변을 입력하세요.',
                      height: 1,
                    ),
              ],
            ),

            SizedBox(height: 16),
            (!isComplete(widget.entry.value, widget.now))
                ? CompleteButton(
                    label: "완료",
                    question: widget.entry.value,
                    completePush: (q) {
                      //완료버튼 누르면 숨기는 로직
                      setState(() {
                        if (q.selectedOptions.isEmpty &&
                            q.answerType == AnswerType.multipleChoice) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('하나 이상 체크해야합니다.')),
                          );
                          return;
                        }

                        if (!q.completedDates.any(
                          (d) =>
                              d.year == widget.now.year &&
                              d.month == widget.now.month &&
                              d.day == widget.now.day,
                        )) {
                          q.completedDates.add(
                            DateTime(
                              widget.now.year,
                              widget.now.month,
                              widget.now.day,
                            ),
                          );
                          saveCounts(q);
                          q.save(); // Hive 저장
                        }
                      });
                    },
                  )
                : CompleteButton(
                    question: widget.entry.value,
                    label: "취소",
                    completePush: (q) {
                      setState(() {
                        q.completedDates.remove(widget.now);
                        if (q.selectedOptions.isNotEmpty) {
                          for (var option in q.selectedOptions) {
                            q.answersCounts[option]--;
                          }
                        }
                        q.save(); // Hive 저장
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
