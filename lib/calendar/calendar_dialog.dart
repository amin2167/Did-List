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
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu(
      context: context,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      position: RelativeRect.fromLTRB(
        offset.dx, // 왼쪽 기준
        offset.dy + size.height, // 위젯 바로 아래
        offset.dx + size.width,
        0,
      ),
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: 220,
            child: StatefulBuilder(
              builder: (context, setDialogState) {
                DateTime _selected = selectedDay;
                return TableCalendar(
                  rowHeight: 36, // 👈 기본값 52 → 줄이기
                  daysOfWeekHeight: 24,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    headerPadding: const EdgeInsets.symmetric(vertical: 4),
                    titleTextStyle: const TextStyle(
                      fontSize: 13, // 👈 헤더 월 텍스트
                      fontWeight: FontWeight.w700,
                    ),
                    // ...
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      fontSize: 12, // 👈 요일 텍스트
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                    weekendStyle: TextStyle(
                      fontSize: 12, // 👈 요일 텍스트
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.transparent, // 👈 배경 투명
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4A4A4A), // 👈 일반 날짜랑 같은 색
                    ),
                    cellMargin: const EdgeInsets.all(4),
                    defaultTextStyle: const TextStyle(
                      fontSize: 12, // 👈 날짜 텍스트
                      color: Color(0xFF4A4A4A),
                    ),
                    weekendTextStyle: const TextStyle(
                      fontSize: 12, // 👈 날짜 텍스트
                      color: Colors.redAccent,
                    ),
                    selectedTextStyle: const TextStyle(
                      fontSize: 12, // 👈 선택된 날짜 텍스트
                      color: Colors.white,
                    ),
                    outsideTextStyle: const TextStyle(
                      fontSize: 12, // 👈 바깥 날짜 텍스트
                    ),
                  ),
                  locale: 'ko_KR',
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  focusedDay: _selected,
                  selectedDayPredicate: (day) => isSameDay(day, _selected),
                  onDaySelected: (selected, focused) {
                    setDialogState(() => _selected = selected);
                    onDaySelected(selected);
                    Navigator.pop(context);
                  },
                  // ... 기존 스타일 그대로
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
