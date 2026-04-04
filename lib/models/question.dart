import 'package:intl/intl.dart';

enum AnswerType { multipleChoice, subjective }

class Question {
  final List<String> weekDayLabels = ['월', '화', '수', '목', '금', '토', '일'];
  String target;
  AnswerType answerType;
  List<String>? answers; //주관식 답변
  Set<int>? selectedOptions; //답변한 선지 인덱스
  Set<DateTime> dates; //날짜
  Set<int> datesIdx;
  bool isAllweek; //매주마다인지
  //final String? subjectiveAnswer;

  Question({
    required this.target,
    required this.answerType,
    this.answers,
    required this.dates,
    required this.datesIdx,
    required this.isAllweek,
    Set<int>? selectedOptions,
  }) : selectedOptions = selectedOptions ?? {};

  @override
  String toString() {
    return 'Question(target: $target, type: $answerType)';
  }
}