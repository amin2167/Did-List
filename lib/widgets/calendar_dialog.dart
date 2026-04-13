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
// class CalendarDialog {
//   static void show(
//     BuildContext context, {
//     required DateTime selectedDay,
//     required Function(DateTime) onDaySelected,
//   }) {
//     showDialog(
//       context: context,
//       builder: (context) {
//           DateTime _selected = selectedDay;
//            return StatefulBuilder(
//             builder: (context, setDialogState) => Dialog
//           (
//         backgroundColor: Colors.white,
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), // 더 둥근 모서리
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           constraints: const BoxConstraints(maxHeight: 480),
//           child: TableCalendar(
//             locale: 'ko_KR',
//             firstDay: DateTime(2000),
//             lastDay: DateTime(2100),
//             focusedDay: selectedDay,
//             selectedDayPredicate: (day) => isSameDay(day, selectedDay),
//             onDaySelected: (selected, focused) {
//               onDaySelected(selected);
//               Navigator.pop(context);
//             },

//             // 1. 헤더 스타일 개선 (폰트 및 아이콘 커스텀)
//             headerStyle: HeaderStyle(
//               formatButtonVisible: false,
//               titleCentered: true,
//               titleTextStyle: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF333333),
//               ),
//               leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.grey, size: 28),
//               rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.grey, size: 28),
//               headerPadding: const EdgeInsets.symmetric(vertical: 8.0),
//             ),

//             // 2. 캘린더 요일 및 날짜 스타일 (가독성 향상)
//             daysOfWeekStyle: const DaysOfWeekStyle(
//               weekdayStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
//               weekendStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
//             ),

//             calendarStyle: CalendarStyle(
//               // 오늘 날짜 강조 (선택되지 않았을 때)
//               todayDecoration: BoxDecoration(
//                 color: Colors.transparent,
//                 border: Border.all(color: const Color(0xFF8E5CF6), width: 1.5), // 테두리만 강조
//                 shape: BoxShape.circle,
//               ),
//               todayTextStyle: const TextStyle(
//                 color: Color(0xFF8E5CF6),
//                 fontWeight: FontWeight.bold,
//               ),

//               // 날짜들 간의 간격 및 텍스트 스타일
//               defaultTextStyle: const TextStyle(color: Color(0xFF4A4A4A), fontWeight: FontWeight.w500),
//               weekendTextStyle: const TextStyle(color: Colors.redAccent),
//               outsideDaysVisible: false, // 이번 달 아닌 날짜 숨기기 (깔끔함)
              
//               // 선택된 날짜의 기본 원형 데코레이션 (selectedDecoration을 명시하지 않으면 패키지 기본값이 적용됨)
//               // 여기서는 배경색을 연한 보라색으로 살짝만 주어 밋밋함을 덜었습니다.
//               selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// }