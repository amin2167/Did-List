import 'package:flutter/material.dart';
import '../../models/question.dart';

class RecordMultipleCard extends StatefulWidget {

  final MapEntry<int, String> entry;
  Question selectedQuestion;
  final DateTime startDate;
  final DateTime endDate;

  RecordMultipleCard({
    super.key, 
    required this.selectedQuestion,
    required this.entry,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<RecordMultipleCard> createState() => _ReCordCardState();
}

class _ReCordCardState extends State<RecordMultipleCard> {

  int dateAnswerCounts(Question q, DateTime start, DateTime end) {
    int sum = 0;
    int i = 0;

    if (q.completedDates != null) {
      for (var date in q.completedDates) {
        if (!date.isBefore(start) && !date.isAfter(end)) {
          sum += q.answersCounts[i];
        }
        i++;
      }
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //이게 타겟이랑 횟수 카드
      alignment: Alignment.topCenter,
      height: 20,
      decoration: BoxDecoration(
        // color: ColorArr[entry.key % selectedQuestion!.answers!.length],
        border: Border.all(color: Color(0xFF5B8DEF), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.entry.value),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.bottomCenter, // 3. 0회 글자: 남은 공간의 정중앙
                child: Text(
                  "${dateAnswerCounts(widget.selectedQuestion, widget.startDate, widget.endDate)} 회",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
