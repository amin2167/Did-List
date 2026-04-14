import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionListProvider extends ChangeNotifier {
  List<Question> savedQuestions = [];

  void updateQuestion(
    Question q, {
    required String target,
    required AnswerType answerType,
    required List<String> options,
    required Set<DateTime> dates,
    required Set<int> datesIdx,
    required bool isAllweek,
  }) {
    q.target = target;
    q.answerType = answerType;
    q.answers = options;
    q.dates = dates;
    q.datesIdx = datesIdx;
    q.isAllweek = isAllweek;
    notifyListeners();
  }

  void addQuestion(Question q) {
    savedQuestions.add(q);
    notifyListeners();
  }

  void deleteQuestion(Question q) {
    savedQuestions.remove(q);
    notifyListeners();
  }

  void saveAnswer(Question q, Set<int> answers) {
    for(var a in answers) {
      if(q.selectedOptions != []) {
        q.selectedOptions.add(a);
      }
    }
    notifyListeners();
  }
}

 