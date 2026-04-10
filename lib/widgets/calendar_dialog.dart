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
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          height: 450,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: TableCalendar(
              locale: 'ko_KR',
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              focusedDay: selectedDay,
              selectedDayPredicate: (day) => isSameDay(day, selectedDay),
              onDaySelected: (selected, focused) {
                onDaySelected(selected); // 부모에게 선택된 날짜 전달
                Navigator.pop(context);
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF5B8DEF), Color(0xFF8E5CF6)],
                  ),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}