import 'package:intl/intl.dart';

enum AnswerType { multipleChoice, subjective }

class Question {
  final List<String> weekDayLabels = ['월', '화', '수', '목', '금', '토', '일'];
  int id;
  String target;
  AnswerType answerType;
  List<String>? answers = []; //선지 리스트 (주관식이면 하나만 잇겟지?)
  List<int>? answersCounts = []; //선지 몇번이나 햇는지 카운팅
  List<int>? selectedOptions = []; //답변한 선지 인덱스
  Set<DateTime> dates; //날짜
  List<DateTime> completedDates = [];


  Set<int> datesIdx; //이건 로직상 필요해서 걍 추가
  bool isAllweek; //매주마다인지
  bool? isIndicate; //홈화면에 떠도 되는지 아닌지
  //final String? subjectiveAnswer;

  Question({
    required this.id,
    required this.target,
    required this.answerType,
    required this.completedDates,
    this.answers,
    this.answersCounts,
    this.isIndicate,
    required this.dates,
    required this.datesIdx,
    required this.isAllweek,
    List<int>? selectedOptions,
  }) : selectedOptions = selectedOptions ?? [];
  

  @override
  String toString() {
    return 'Question(target: $target, type: $answerType)';
  }
}