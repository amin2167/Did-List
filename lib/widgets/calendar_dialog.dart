import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog {
  static void show(
    BuildContext context, {
    required DateTime selectedDay,
    required Function(DateTime) onDaySelected,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        DateTime _selected = selectedDay;
        return StatefulBuilder(
          builder: (context, setDialogState) => Dialog(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              constraints: const BoxConstraints(maxHeight: 480),
              child: TableCalendar(
                locale: 'ko_KR',
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                focusedDay: _selected,
                selectedDayPredicate: (day) => isSameDay(day, _selected),
                onDaySelected: (selected, focused) {
                  setDialogState(() {
                    _selected = selected;
                  });
                  onDaySelected(selected);
                  Navigator.pop(context);
                },
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF333333),
                  ),
                  leftChevronIcon: const Icon(
                    Icons.chevron_left,
                    color: Colors.grey,
                    size: 28,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 28,
                  ),
                  headerPadding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                  weekendStyle: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: const Color(0xFF8E5CF6),
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: const TextStyle(
                    color: Color(0xFF8E5CF6),
                    fontWeight: FontWeight.bold,
                  ),
                  defaultTextStyle: const TextStyle(
                    color: Color(0xFF4A4A4A),
                    fontWeight: FontWeight.w500,
                  ),
                  weekendTextStyle: const TextStyle(color: Colors.redAccent),
                  outsideDaysVisible: false,
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
