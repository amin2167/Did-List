import 'package:flutter/material.dart';
import 'package:flutter_main/common/my_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'widgets/build_action_buttion.dart';
import '../../models/question.dart';
import '../../providers/question_edit_provider.dart';
import '../../providers/question_list_provider.dart';
import '../../common/shadow_box.dart';
import 'widgets/answer_text_field.dart';
import 'widgets/build_type_button.dart';
import 'widgets/calendar_dialog_editing.dart';
import 'widgets/question_drops.dart';
import './widgets/build_answer_tile.dart';
import './widgets/delete_buttion.dart';

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
  List<int> selectedDayIdx = [0, 1, 2, 3, 4, 5, 6];
  Set<DateTime> selectedDays = {};
  final List<String> weekDayLabels = ['월', '화', '수', '목', '금', '토', '일'];

  void _removeOption(int idx) {
    setState(() {
      optionControllers[idx].dispose();
      optionControllers.removeAt(idx);
    });
  }

  void _addOption() {
    setState(() {
      optionControllers.add(TextEditingController());
    });
  }

  @override
  void initState() {
    super.initState();

    now = DateTime.now();

    optionControllers[0].text = '했음';
    optionControllers[1].text = '안했음';

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
      completedOptions: [],
    );

    providerList.addQuestion(q);

    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text('저장되었습니다!')));
    Navigator.pop(context);
  }

  void modify() {
    final provider = context.read<QuestionListProvider>();
    final providerEdit = context.read<QuestionEditProvider>();

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

  //현제 날짜 리턴하는 함수
  DateTime changeDate(int diff) {
    final now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    DateTime resultWeekDay = monday.add(Duration(days: diff));
    return DateTime(resultWeekDay.year, resultWeekDay.month, resultWeekDay.day);
  }

  @override
  Widget build(BuildContext context) {
    final editProvider = context.watch<QuestionEditProvider>();
    final listProvider = context.watch<QuestionListProvider>();

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Color(0xFFEEEEF8),
          appBar: AppBar(
            backgroundColor: Color(0xFFEEEEF8),
            centerTitle: true,
            title: Text('새 목표 설정'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('날짜'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: QuestionDrops(
                            selectedDates: selectedDays,
                            selectedDayIdx: selectedDayIdx,
                            weekDayLabels: weekDayLabels,
                            onChanged: (dayIdx, days) {
                              setState(() {
                                selectedDayIdx = dayIdx;
                                selectedDays = days;
                                selectedDayIdx.sort();
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
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

                        //답변방식 객관식/주관식 선택하는부분

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 8),
                        //   child: Text('답변 방식'),
                        // ),

                        // Row(
                        //   children: [
                        //     BuildTypeButton(
                        //       label: '객관식',
                        //       isSelected:
                        //           provider.answerType == AnswerType.multipleChoice,
                        //       onTap: () =>
                        //           provider.setAnswerType(AnswerType.multipleChoice),
                        //     ),
                        //     const SizedBox(width: 16), // 버튼 사이 간격
                        //     BuildTypeButton(
                        //       label: '주관식',
                        //       isSelected:
                        //           provider.answerType == AnswerType.subjective,
                        //       onTap: () =>
                        //           provider.setAnswerType(AnswerType.subjective),
                        //     ),
                        //   ],
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: BuildAnswerTile(
                            provider: editProvider,
                            optionControllers: optionControllers,
                            onAddOption: _addOption,
                            onRemoveOption: _removeOption,
                          ),
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
                                      selectedDays = days;
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
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            DeleteButton(
                              label: '삭제',
                              icon: FontAwesomeIcons.trashCan,
                              textColor: Colors.white,
                              onTap: () {
                                if (widget.nowQuestion == null) {
                                  Navigator.pop(context);
                                }
                                if (widget.nowQuestion != null) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        title: const Text("목표 삭제"),
                                        content: Text(
                                          "정말 삭제하시겠습니까?",
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
                                              listProvider.deleteQuestion(
                                                widget.nowQuestion!,
                                              );
                            
                                              // 3. 다이얼로그 닫기
                                              Navigator.pop(dialogContext);
                                              Navigator.pop(context);
                            
                                              // 4. 삭제 완료 피드백 (스낵바)
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text("삭제되었습니다."),
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
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
