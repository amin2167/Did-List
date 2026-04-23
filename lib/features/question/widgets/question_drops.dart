import 'package:flutter/material.dart';

class QuestionDrops extends StatefulWidget {
  final List<int> selectedDayIdx;
  final List<String> weekDayLabels;
  Set<DateTime> selectedDates;
  final Function(List<int>, Set<DateTime>) onChanged;

  QuestionDrops({
    super.key,
    required this.selectedDayIdx,
    required this.weekDayLabels,
    required this.selectedDates,
    required this.onChanged,
  });

  
  
  @override
  State<QuestionDrops> createState() => _QuestionDropsState();
}

class _QuestionDropsState extends State<QuestionDrops> {
  late List<int> _selectedDayIdx; 
  late Set<DateTime> _selectedDates;

  @override
  void initState() {
    super.initState();
    _selectedDayIdx = widget.selectedDayIdx.isEmpty
      ? [0, 1, 2, 3, 4, 5, 6]
      : List.from(widget.selectedDayIdx);

    _selectedDates = Set.from(widget.selectedDates);
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
        final bool isSelected = _selectedDayIdx.contains(index);
        return GestureDetector(
          onTap: () {
            setState(() {
              final isNowSelected = _selectedDayIdx.contains(index);
              if (isNowSelected) {
                _selectedDayIdx.remove(index);
                _selectedDates.remove(changeDate(index));
              } else {
                _selectedDayIdx.add(index);
                _selectedDates.add(changeDate(index));
              }
              widget.onChanged(_selectedDayIdx, _selectedDates);
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
