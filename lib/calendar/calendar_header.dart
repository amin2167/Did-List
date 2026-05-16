// import 'package:flutter/material.dart';
// import 'package:easy_date_timeline/easy_date_timeline.dart';
// import 'package:flutter_main/features/question/question_editor.dart';

// import 'calendar_dialog.dart';
// import '../common/date_selector.dart';
// import '../common/plusAiconButton.dart';

// class CalendarHeader extends StatelessWidget {
//   final DateTime date;
//   final Function(DateTime) onDateChanged;

//   CalendarHeader({super.key, required this.date, required this.onDateChanged});

//   final EasyInfiniteDateTimelineController _controller =
//       EasyInfiniteDateTimelineController();

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       color: Color(0xFFF0EEFF),
//       child: EasyInfiniteDateTimeLine(
//         locale: 'ko',
//         controller: _controller,
//         firstDate: DateTime(2024),
//         focusDate: date, // 현재 선택된 날짜
//         lastDate: DateTime(2026, 12, 31),
//         onDateChange: (selectedDate) {
//           onDateChanged(selectedDate);
//         },
        
//         headerBuilder: (context, data) {
//           return SizedBox(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     CalendarDialog.show(
//                       context,
//                       selectedDay: date,
//                       onDaySelected: (pickedDate) {
//                         onDateChanged(pickedDate);
//                         _controller.animateToDate(pickedDate);
//                       },
//                     );
//                   },
//                   child: DateSelector(now: date),
//                 ),
//                 PlusAiconButton(page: const AddQuestionPage(), label: '새 목표'),
//               ],
//             ),
//           );
//         },
      
//         dayProps: EasyDayProps(
//           height: MediaQuery.of(context).size.height * 0.06,
//           width: MediaQuery.of(context).size.width * 0.12,
//           dayStructure: DayStructure.dayStrDayNum,
//           // inactiveDayStyle: DayStyle(
//           //   decoration: BoxDecoration( 
//           //     borderRadius: BorderRadius.all(Radius.circular(16)),
//           //     border: Border.all(
//           //     color: Colors.grey.shade300,),
//           //   ),
//           // ) ,
//           activeDayStyle: DayStyle(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(16)),
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Color(0xFF5B8DEF), Color(0xFF8E5CF6)],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:easy_date_timeline/easy_date_timeline.dart';
// import 'package:flutter_main/features/question/question_editor.dart';

// import 'calendar_dialog.dart';
// import '../common/date_selector.dart';
// import '../common/plusAiconButton.dart';

// class CalendarHeader extends StatelessWidget {
//   final DateTime date;
//   final Function(DateTime) onDateChanged;

//   CalendarHeader({super.key, required this.date, required this.onDateChanged});

//   final EasyInfiniteDateTimelineController _controller =
//       EasyInfiniteDateTimelineController();

//   @override
//   Widget build(BuildContext context) {
//     final double dayHeight = MediaQuery.of(context).size.height * 0.06;

//     return Container(
//       color: Color(0xFFF0EEFF),
//       child: Column(
//         children: [
//           // 헤더: 날짜 선택 + 새 목표 버튼
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     CalendarDialog.show(
//                       context,
//                       selectedDay: date,
//                       onDaySelected: (pickedDate) {
//                         onDateChanged(pickedDate);
//                         _controller.animateToDate(pickedDate);
//                       },
//                     );
//                   },
//                   child: DateSelector(now: date),
//                 ),
//                 PlusAiconButton(page: const AddQuestionPage(), label: '새 목표'),
//               ],
//             ),
//           ),

//           // 날짜 스크롤 바 + 화살표 (Stack으로 화살표를 날짜 바 가운데 높이에 배치)
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               // 날짜 스크롤 (양쪽 화살표 공간만큼 패딩)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 28.0),
//                 child: EasyInfiniteDateTimeLine(
//                   locale: 'ko',
//                   controller: _controller,
//                   firstDate: DateTime(2024),
//                   focusDate: date,
//                   lastDate: DateTime(2026, 12, 31),
//                   showTimelineHeader: false, // 금요일, 날짜 텍스트 제거
//                   onDateChange: (selectedDate) {
//                     onDateChanged(selectedDate);
//                   },
//                   dayProps: EasyDayProps(
//                     height: dayHeight,
//                     width: MediaQuery.of(context).size.width * 0.12,
//                     dayStructure: DayStructure.dayStrDayNum,
//                     activeDayStyle: DayStyle(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(16)),
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [Color(0xFF5B8DEF), Color(0xFF8E5CF6)],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // 왼쪽 화살표
//               Positioned(
//                 left: 0,
//                 child: GestureDetector(
//                   onTap: () {
//                     final prev = date.subtract(const Duration(days: 7));
//                     onDateChanged(prev);
//                     _controller.animateToDate(prev);
//                   },
//                   child: const Icon(Icons.chevron_left, color: Colors.grey),
//                 ),
//               ),

//               // 오른쪽 화살표
//               Positioned(
//                 right: 0,
//                 child: GestureDetector(
//                   onTap: () {
//                     final next = date.add(const Duration(days: 7));
//                     onDateChanged(next);
//                     _controller.animateToDate(next);
//                   },
//                   child: const Icon(Icons.chevron_right, color: Colors.grey),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_main/features/question/question_editor.dart';

import 'calendar_dialog.dart';
import '../common/date_selector.dart';
import '../common/plusAiconButton.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onDateChanged;

  CalendarHeader({super.key, required this.date, required this.onDateChanged});

  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF0EEFF),
      child: Column(
        children: [
          // 헤더: 날짜 선택 + 새 목표 버튼
          Row(
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

          // 양쪽 페이드 그라디언트 + 날짜 스크롤
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Color(0xFFF0EEFF),
                Colors.transparent,
                Colors.transparent,
                Color(0xFFF0EEFF),
              ],
              stops: [0.0, 0.08, 0.92, 1.0],
            ).createShader(bounds),
            blendMode: BlendMode.dstOut,
            child: EasyInfiniteDateTimeLine(
              locale: 'ko',
              controller: _controller,
              firstDate: DateTime(2024),
              focusDate: date,
              lastDate: DateTime(2026, 12, 31),
              showTimelineHeader: false,
              onDateChange: (selectedDate) {
                onDateChanged(selectedDate);
              },
              dayProps: EasyDayProps(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.12,
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
            ),
          ),
        ],
      ),
    );
  }
}