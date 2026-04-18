import 'package:flutter/material.dart';
import 'package:flutter_main/widgets/my_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../core/layout/base_page.dart';
import '../models/question.dart';
import '../providers/question_edit_provider.dart';
import '../providers/question_list_provider.dart';
import '../widgets/shadow_box.dart';
import '../widgets/question_page/answer_text_field.dart';
import '../widgets/question_page/build_type_button.dart';
import '../widgets/question_page/calendar_dialog_editing.dart';
import '../widgets/question_page/question_drops.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key, this.nowQuestion});

  final Question? nowQuestion;

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  TextEditingController targetController = TextEditingController();
  List<TextEditingController> optionControllers = List.generate(
    2,
    (_) => TextEditingController(),
  );

  late DateTime now;

  TextEditingController dateController = TextEditingController();

  bool isAllweek = true;
  List<int> selectedDayIdx = [];
  Set<DateTime> selectedDays = {};
  final List<String> weekDayLabels = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  void initState() {
    super.initState();

    now = DateTime.now();

    final q = widget.nowQuestion;

    if (q != null) {
      selectedDayIdx = List.from(q.datesIdx);
      selectedDays = q.dates;
      isAllweek = q.isAllweek;
    }

    final edit = context.read<QuestionEditProvider>();

    if (q != null) {
      targetController.text = q.target;
      edit.setAnswerType(q.answerType); //<<이거가 주관식 눌르면 주관식이라고 수정되게하는코드
      if (q.answerType == AnswerType.multipleChoice) {
        for (final c in optionControllers) {
          c.dispose();
        }
        optionControllers = q.answers
            .map((v) => TextEditingController(text: v))
            .toList();
      }
    }
  }

  //수정하려고하면
  @override
  void dispose() {
    targetController.dispose();
    for (var c in optionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void validation() {
    final providerEdit = context.read<QuestionEditProvider>();
    final providerList = context.read<QuestionListProvider>();

    // 유효성 검사
    if (targetController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('목표를 입력해주세요!')));
      return;
    }

    if (providerEdit.answerType == AnswerType.multipleChoice) {
      if (optionControllers.any((c) => c.text.trim().isEmpty)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('모든 선지를 입력해주세요!')));
        return;
      }
    }

    if (selectedDayIdx.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('요일을 하나 이상 선택해주세요!')));
      return;
    }
    // 저장
    Question q = Question(
      id: providerList.savedQuestions.length,
      target: targetController.text,
      answerType: providerEdit.answerType,
      subjectAnswers: "test",
      answers: optionControllers.map((c) => c.text).toList(),
      dates: selectedDays,
      completedDates: [],
      datesIdx: selectedDayIdx,
      selectedOptions: [],
      answersCounts: [],
      isAllweek: isAllweek,
    );

    providerList.addQuestion(q);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('저장되었습니다!')));
    Navigator.pop(context);
  }

  void modify() {
    final provider = context.read<QuestionListProvider>();
    final providerEdit = context.read<QuestionEditProvider>();

    Question q = widget.nowQuestion!;

    provider.updateQuestion(
      q,
      target: targetController.text,
      answerType: providerEdit.answerType,
      options: optionControllers.map((v) => v.text).toList(),
      dates: selectedDays,
      datesIdx: selectedDayIdx,
      isAllweek: isAllweek,
    );

    Navigator.pop(context);
  }

  void _addOption() {
    setState(() {
      optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int idx) {
    setState(() {
      optionControllers[idx].dispose();
      optionControllers.removeAt(idx);
    });
  }

  //현제 날짜 리턴하는 함수
  DateTime changeDate(int diff) {
    final now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    DateTime resultWeekDay = monday.add(Duration(days: diff));
    return DateTime(resultWeekDay.year, resultWeekDay.month, resultWeekDay.day);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionEditProvider>();

    return BasePage(
      title: '새 목표 설정',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('날짜'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: QuestionDrops(
                      selectedDates: selectedDays,
                      selectedDayIdx: selectedDayIdx,
                      weekDayLabels: weekDayLabels,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text('목표'),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: ShadowBox(
                          widget: MyTextField(
                            height: 2,
                            controller: targetController,
                            label: "목표를 입력하세요",
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text('답변 방식'),
                  ),

                  Row(
                    children: [
                      BuildTypeButton(
                        label: '객관식',
                        isSelected:
                            provider.answerType == AnswerType.multipleChoice,
                        onTap: () =>
                            provider.setAnswerType(AnswerType.multipleChoice),
                      ),
                      const SizedBox(width: 16), // 버튼 사이 간격
                      BuildTypeButton(
                        label: '주관식',
                        isSelected:
                            provider.answerType == AnswerType.subjective,
                        onTap: () =>
                            provider.setAnswerType(AnswerType.subjective),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: _buildAnswerTile(provider), // 👈 여기서 분기!
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text('주기'),
                  ),

                  Row(
                    children: [
                      BuildTypeButton(
                        label: '매주',
                        isSelected: isAllweek == true,
                        onTap: () {
                          setState(() {
                            isAllweek = true;
                          });
                        },
                      ),

                      const SizedBox(width: 16), // 버튼 사이 간격
                      BuildTypeButton(
                        label: '하루만',
                        isSelected: isAllweek == false,
                        onTap: () {
                          setState(() {
                            isAllweek = false;
                          });

                          CalendarDialogEditing.show(
                            context,
                            selectedDays: selectedDays,
                            onDaysUpdated: (days) {
                              setState(() {
                                selectedDayIdx = days
                                    .map((date) => date.weekday - 1)
                                    .toList();
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
          Row(
            children: [
              BuildActionButton(
                label: '저장',
                onTap: () {
                  if (widget.nowQuestion == null) {
                    for (var i in selectedDayIdx) {
                      selectedDays.add(changeDate(i));
                    }
                    //+버튼이면
                    validation();
                  } else {
                    //질문tile이면
                    selectedDays = {};
                    //selectedDayIdx가 추가되면
                    for (var i in selectedDayIdx) {
                      selectedDays.add(changeDate(i));
                    }
                    modify();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 👇 객관식/주관식 분기
  Widget _buildAnswerTile(QuestionEditProvider provider) {
    if (provider.answerType == AnswerType.multipleChoice) {
      // 객관식
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text('선지'),
          ),
          for (int i = 0; i < optionControllers.length; i++)
            Row(
              children: [
                AnswerTextField(
                  label: '선지${i + 1}',
                  controller: optionControllers[i],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.task_alt,
                    color:
                        (widget.nowQuestion?.selectedOptions.contains(i) ??
                            false)
                        ? Colors.green
                        : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () => _removeOption(i),
                  icon: Icon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.red,
                    size: 21,
                  ),
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: TextButton.icon(
              onPressed: _addOption,
              icon: Icon(Icons.add),
              label: Text('선지 추가'),
            ),
          ),
        ],
      );
    } else {
      //주관식
      return SizedBox();
    }
  }
}

// 애는 저장되는 녀석을 다루는 provider

class BuildActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color textColor = Colors.black87;
  final IconData? icon;

  BuildActionButton({
    super.key,
    required this.label,
    required this.onTap,
    // Color color = Colors.white, // 기본값 흰색
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Widget buttonContent = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 55, // 저장 버튼은 조금 더 두툼하게 55 추천
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF5B8DEF), // 파랑
            Color(0xFF8E5CF6), // 보라
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 20),
              const SizedBox(width: 8),
            ],
            Icon(Icons.save_outlined, color: Colors.white),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

    // TODO: implement build
    return Expanded(
      child: InkWell(onTap: onTap, child: buttonContent),
    );
  }
}
  

  // 가로를 꽉 채워야 하면 Expanded로 감싸고, 아니면 그냥 반환
  