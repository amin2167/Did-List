// import 'package:flutter/material.dart';
// import '../models/question.dart';

// class QuestionListProvider extends ChangeNotifier {
//   List<Question> savedQuestions = [];

//   void updateQuestion(
//     Question q, {
//     required String target,
//     required AnswerType answerType,
//     required List<String> options,
//     required Set<DateTime> dates,
//     required List<int> datesIdx,
//     required bool isAllweek,
//   }) {
//     q.target = target;
//     q.answerType = answerType;
//     q.answers = options;
//     q.dates = dates;
//     q.datesIdx = datesIdx;
//     q.isAllweek = isAllweek;
//     notifyListeners();
//   }

//   void addQuestion(Question q) {
//     savedQuestions.add(q);
//     notifyListeners();
//   }

//   void deleteQuestion(Question q) {
//     savedQuestions.remove(q);
//     notifyListeners();
//   }

//   void saveAnswer(Question q, Set<int> answers) {
//     for(var a in answers) {
//       if(q.selectedOptions != []) {
//         q.selectedOptions.add(a);
//       }
//     }
//     notifyListeners();
//   }
// }

 
 import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/question.dart';

class QuestionListProvider extends ChangeNotifier {
  static const String _boxName = 'questions';
  late Box<Question> _box;

  List<Question> savedQuestions = [];

  // 앱 시작 시 호출
  Future<void> init() async {
    _box = await Hive.openBox<Question>(_boxName);
    savedQuestions = _box.values.toList();
    notifyListeners();
  }

  void updateQuestion(
    Question q, {
    required String target,
    required AnswerType answerType,
    required List<String> options,
    required Set<DateTime> dates,
    required List<int> datesIdx,
    required bool isAllweek,
  }) {
    q.target = target;
    q.answerType = answerType;
    q.answers = options;
    q.dates = dates;
    q.datesIdx = datesIdx;
    q.isAllweek = isAllweek;
    q.save(); // Hive 저장
    notifyListeners();
  }

  void addQuestion(Question q) {
    _box.add(q); // Hive 저장
    savedQuestions = _box.values.toList();
    notifyListeners();
  }

  void deleteQuestion(Question q) {
    q.delete(); // Hive 삭제
    savedQuestions = _box.values.toList();
    notifyListeners();
  }

  void saveAnswer(Question q, Set<int> answers) {
    for (var a in answers) {
      if (q.selectedOptions != []) {
        q.selectedOptions.add(a);
      }
    }
    q.save(); // Hive 저장
    notifyListeners();
  }
}