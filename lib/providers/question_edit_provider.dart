import 'package:flutter/material.dart';
import '../models/question.dart';


class QuestionEditProvider extends ChangeNotifier {
  AnswerType answerType = AnswerType.multipleChoice;

  void setAnswerType(AnswerType v) {
    answerType = v;
    notifyListeners();
  }

}
