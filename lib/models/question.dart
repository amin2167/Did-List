// import 'package:intl/intl.dart';

// enum AnswerType { multipleChoice, subjective }

// class Question {
//   final List<String> weekDayLabels = ['월', '화', '수', '목', '금', '토', '일'];
//   int id;
//   String target;
//   AnswerType answerType;
//   List<String> answers = []; //선지 리스트 (객관식만) (option)
//   String subjectAnswers; //주관식 답변
//   List<int> answersCounts = []; //선지 몇번이나 햇는지 카운팅
//   List<int> selectedOptions = []; //답변한 선지 인덱스
//   Set<DateTime> dates; //날짜
//   List<DateTime> completedDates = []; //완료한 날짜


//   List<int> datesIdx; //이건 로직상 필요해서 걍 추가
//   bool isAllweek; //매주마다인지

//   Question({
//     required this.id,
//     required this.target,
//     required this.answerType,
//     required this.completedDates,
//     required this.subjectAnswers,
//     required this.answers,
//     required this.answersCounts,
//     required this.dates,
//     required this.datesIdx,
//     required this.isAllweek,
//     required this.selectedOptions,
//   });
  

//   @override
//   String toString() {
//     return 'Question(target: $target, type: $answerType)';
//   }
// }
import 'package:hive/hive.dart';

part 'question.g.dart';

enum AnswerType { multipleChoice, subjective }

@HiveType(typeId: 0)
class Question extends HiveObject {
  final List<String> weekDayLabels = ['월', '화', '수', '목', '금', '토', '일'];

  @HiveField(0)
  int id;

  @HiveField(1)
  String target;

  @HiveField(2)
  int answerTypeIndex; // AnswerType enum → int로 저장

  @HiveField(3)
  List<String> answers; // 선지 리스트 (객관식만)

  @HiveField(4)
  String subjectAnswers; // 주관식 답변

  @HiveField(5)
  List<int> answersCounts; // 선지 몇번이나 했는지 카운팅

  @HiveField(6)
  List<int> selectedOptions; // 답변한 선지 인덱스

  @HiveField(7)
  List<DateTime> datesList; // Set<DateTime> → List<DateTime>로 저장

  @HiveField(8)
  List<DateTime> completedDates; // 완료한 날짜

  @HiveField(9)
  List<int> datesIdx; // 로직상 필요

  @HiveField(10)
  bool isAllweek; // 매주마다인지

  // 기존 코드 호환용 getter/setter
  AnswerType get answerType => AnswerType.values[answerTypeIndex];
  set answerType(AnswerType v) => answerTypeIndex = v.index;

  Set<DateTime> get dates => datesList.toSet();
  set dates(Set<DateTime> v) => datesList = v.toList();

  Question({
    required this.id,
    required this.target,
    AnswerType? answerType,
    required this.completedDates,
    required this.subjectAnswers,
    required this.answers,
    required this.answersCounts,
    Set<DateTime>? dates,
    required this.datesIdx,
    required this.isAllweek,
    required this.selectedOptions,
    int? answerTypeIdx,
    List<DateTime>? datesListParam,
  })  : answerTypeIndex = answerTypeIdx ?? answerType?.index ?? 0,
        datesList = datesListParam ?? dates?.toList() ?? [];

  @override
  String toString() {
    return 'Question(target: $target, type: $answerType)';
  }
}