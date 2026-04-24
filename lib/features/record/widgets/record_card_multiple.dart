import 'package:flutter/material.dart';
import 'package:flutter_main/common/gradient_circle.dart';
import 'package:flutter_main/common/gradient_dot.dart';
import '../../../models/question.dart';

class RecordMultipleCard extends StatelessWidget {
  MapEntry<int, Question> entry;
  Duration duration;
  // final String target;
  // final List<DateTime> completedDates;
  // final List<int> answersCounts;
  // final List<String> answers;

  // final DateTime startDate;
  // final DateTime endDate;

  RecordMultipleCard({
    super.key,
    required this.entry,
    required this.duration,
    // required this.target,
    // required this.completedDates,
    // required this.answersCounts,
    // required this.answers,

    // required this.startDate,
    // required this.endDate,
  });

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
    int totalCount = 0;
    for (int i in entry.value.answersCounts) {
      totalCount += i;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 👇 상단 아이콘 + 타이틀 영역
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEF8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.bar_chart,
                    color: Color(0xFF5B4FCF),
                    size: 20,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.value.target,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${duration.inDays}일 동안',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      '총 ${totalCount}회 기록',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Divider(color: Colors.grey.shade100, height: 1),
            SizedBox(height: 12),
            // 👇 선지별 게이지바
            if (entry.value.answers.isNotEmpty)
              for (int i = 0; i < entry.value.answers.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientDot(text: entry.value.answers[i]),
                          Text(
                            entry.value.answersCounts.isEmpty
                                ? '0회'
                                : '${entry.value.answersCounts[i]}회',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: totalCount == 0
                            ? 0
                            : entry.value.answersCounts[i] / totalCount,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF5B4FCF),
                        ),
                        borderRadius: BorderRadius.circular(8),
                        minHeight: 8,
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
