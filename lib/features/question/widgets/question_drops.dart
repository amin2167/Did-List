import 'package:flutter/material.dart';

class QuestionDrops extends StatefulWidget {
  final List<int> selectedDayIdx;
  final List<String> weekDayLabels;
  Set<DateTime> selectedDates;

  QuestionDrops({
    super.key,
    required this.selectedDayIdx,
    required this.weekDayLabels,
    required this.selectedDates,
  });

  
  
  @override
  State<QuestionDrops> createState() => _QuestionDropsState();
}

class _QuestionDropsState extends State<QuestionDrops> {
  late List<int> _selectedDayIdx; 

  @override
  void initState() {
    super.initState();
    _selectedDayIdx = widget.selectedDayIdx.isEmpty
        ? [0, 1, 2, 3, 4, 5, 6]
        : List.from(widget.selectedDayIdx);
  }
  DateTime changeDate(int diff) {
    final now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    DateTime resultWeekDay = monday.add(Duration(days: diff));
    return DateTime(resultWeekDay.year, resultWeekDay.month, resultWeekDay.day);
}

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
      children: List.generate(7, (index) {
        bool isSelected = widget.selectedDayIdx.contains(index);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                widget.selectedDayIdx.remove(index);
                widget.selectedDates.remove(changeDate(index));
              } else {
                widget.selectedDayIdx.add(index);
                widget.selectedDates.add(changeDate(index));
              }
            });
          },
          child: Container(
            // duration: const Duration(milliseconds: 200), //
            width: MediaQuery.of(context).size.width * 0.11,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [Color(0xFF5B8DEF), Color(0xFF8E5CF6)],
                    )
                  : null,
              color: isSelected ? null : Colors.white,
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : Colors.grey.shade300,
              ),
            ),
            child: Center(
              child: Text(
                widget.weekDayLabels[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
