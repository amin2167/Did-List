import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_main/pages/question_editor.dart';

import './calendar_dialog.dart';
import './date_selector.dart';
import './plusAiconButton.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onDateChanged;

  CalendarHeader({super.key, required this.date, required this.onDateChanged});

  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return EasyInfiniteDateTimeLine(
      locale: 'ko',
      controller: _controller,
      firstDate: DateTime(2024),
      focusDate: date, // 현재 선택된 날짜
      lastDate: DateTime(2026, 12, 31),
      onDateChange: (selectedDate) {
        onDateChanged(selectedDate);
      },
      headerBuilder: (context, data) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  CalendarDialog.show(
                    context,
                    selectedDay: date,
                    onDaySelected: (pickedDate) {
                      onDateChanged(pickedDate);
                      _controller.animateToDate(pickedDate);
                    },
                  );
                },
                child: DateSelector(now: date),
              ),
              PlusAiconButton(page: const AddQuestionPage(), label: '새 목표'),
            ],
          ),
        );
      },

      dayProps: EasyDayProps(
        height: MediaQuery.of(context).size.height * 0.08,
        dayStructure: DayStructure.dayStrDayNum,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF5B8DEF), Color(0xFF8E5CF6)],
            ),
          ),
        ),
      ),
    );
  }
}
