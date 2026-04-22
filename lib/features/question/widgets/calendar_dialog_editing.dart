import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialogEditing {
  static void show(
    BuildContext context, {
    required Set<DateTime> selectedDays, // 이름을 복수형으로 변경
    required Function(Set<DateTime>) onDaysUpdated, // 리스트 전체를 반환하도록 변경
  }) {
    showDialog(
      context: context,
      builder: (context) {
        // 내부 상태 관리를 위한 리스트 복사
        Set<DateTime> _selectedList = Set.from(selectedDays);

        return StatefulBuilder(
          builder: (context, setDialogState) => Dialog(
            backgroundColor: Colors.white,
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
                // 포커스는 리스트의 마지막 날짜 혹은 오늘 날짜로 지정
                focusedDay: _selectedList.isNotEmpty
                    ? _selectedList.last
                    : DateTime.now(),

                // [중요] 다중 선택 로직: 리스트에 해당 날짜가 있는지 확인
                selectedDayPredicate: (day) {
                  return _selectedList.any(
                    (selectedDay) => isSameDay(selectedDay, day),
                  );
                },

                onDaySelected: (selected, focused) {
                  setDialogState(() {
                    // 이미 선택된 날짜면 제거, 아니면 추가 (Toggle 방식)
                    bool isAlreadySelected = _selectedList.any(
                      (d) => isSameDay(d, selected),
                    );

                    if (isAlreadySelected) {
                      _selectedList.removeWhere((d) => isSameDay(d, selected));
                    } else {
                      _selectedList.add(selected);
                    }
                  });
                  // 부모 위젯에 업데이트된 리스트 전달
                  onDaysUpdated(_selectedList);
                },

                // 스타일 설정 (기존과 동일)
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  // [수정] 선택된 날짜의 글자 스타일 추가
                  selectedTextStyle: const TextStyle(
                    color: Colors.white, // 배경이 보라색이므로 글자는 하얀색으로
                    fontWeight: FontWeight.bold,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFF8E5CF6),
                    shape: BoxShape.circle,
                  ),

                  // 오늘 날짜 스타일 명시적 지정
                  todayTextStyle: const TextStyle(
                    color: Color(0xFF8E5CF6),
                    fontWeight: FontWeight.bold,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.transparent, // 배경은 비우고 테두리만 유지
                    border: Border.all(
                      color: const Color(0xFF8E5CF6),
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),

                  // 날짜 사이의 간격 문제 방지
                  outsideDaysVisible: false,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
