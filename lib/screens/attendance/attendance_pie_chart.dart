import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const List<Color> color = [
  Color(0xff845bef),
  Color(0xff0293ee),
  Color(0xfff8b400),
  Color(0xff13d38e),
  Color(0xffd2e603),
];

class AttendancePieChartOld extends StatefulWidget {
  final List? attendanceList;

  const AttendancePieChartOld({Key? key, this.attendanceList})
      : super(key: key);
  @override
  _AttendancePieChartOldState createState() => _AttendancePieChartOldState();
}

class _AttendancePieChartOldState extends State<AttendancePieChartOld> {
  // int? touchedIndex = 0;
  int? touchedIndex = -1;

  // List<PieChartSectionData> showSections(int touchIndex) {
  //   //return PieData.data
  //   return widget.attendanceList!
  //       .asMap()
  //       .map<int, PieChartSectionData>((index, data) {
  //         final isTouched = index == touchIndex;
  //         final double fontSize = isTouched ? 25 : 16;
  //         final double radius = isTouched ? 60 : 50;
  //         final value = PieChartSectionData(
  //           // color: data.color,
  //           color: color[index],
  //           // value: data.percent,
  //           value: (widget.attendanceList?[index]['attendance']).toDouble(),
  //           // value: 10.0,
  //           radius: radius,
  //           // title: '${data.percent}%',
  //           title: '${widget.attendanceList?[index]['attendance']}%',
  //           titleStyle: TextStyle(
  //             fontSize: fontSize,
  //             fontWeight: FontWeight.bold,
  //             color: Color(0xffffffff),
  //           ),
  //         );
  //         return MapEntry(index, value);
  //       })
  //       .values
  //       .toList();
  // }
  List<PieChartSectionData> showSections(int touchIndex) {
    //return PieData.data
    return widget.attendanceList!
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final isTouched = index == touchIndex;
          final double fontSize = isTouched ? 25 : 16;
          final double radius = isTouched ? 60 : 50;
          final value = PieChartSectionData(
            // color: data.color,
            color: color[index],
            // value: data.percent,
            value: (widget.attendanceList?[index]['attendance']).toDouble(),
            // (widget.attendanceList?[index]).toDouble(),
            //  (widget.attendanceList?[index]['attendance']).toDouble(),
            // value: 10.0,
            radius: radius,
            // title: '${data.percent}%',
            title: '${widget.attendanceList?[index]['attendance']}%',
            //  title: '${widget.attendanceList?[index]}%',
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
          return MapEntry(index, value);
        })
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.attendanceList);
    List<int> allAttendance = [];
    List<int> newList = [];

    for (var item in widget.attendanceList!) {
      allAttendance.add(item['attendance']);
      newList.add(item['attendance']);
    }
    print('All Attendance $allAttendance');
    //  newList = allAttendance;
    print('New List $newList');
    newList.sort();
    // allAttendance.sort();
    // print(allAttendance.last);
    print('All List $allAttendance');

    print('New List $newList');
    print(allAttendance.indexOf(newList.last));
    int reqData = allAttendance.indexOf(newList.last);
    //  print(allAttendance);

    return AspectRatio(
      aspectRatio: 17,
      child: PieChart(PieChartData(
          pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          }),
          startDegreeOffset: 180,
          borderData: FlBorderData(
            show: false,
          ),
          // sectionsSpace: 1,
          // centerSpaceRadius: 0,

          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: showSections(reqData))),
    );

    // PieChartData(

    //   pieTouchData:
    //       PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {
    //     //   pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {

    //     setState(() {
    //       if (!event.isInterestedForInteractions ||
    //           pieTouchResponse == null ||
    //           pieTouchResponse.touchedSection == null) {
    //         touchedIndex = -1;
    //         return;
    //       }
    //       touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
    //     });

    //     // setState(() {
    //     //   if (pieTouchResponse.touchInput is FlLongPressEnd ||
    //     //       pieTouchResponse.touchInput is FlPanEnd) {
    //     //     touchedIndex = reqData;
    //     //   } else {
    //     //     // touchedIndex = pieTouchResponse.touchedSectionIndex;
    //     //     touchedIndex = reqData;
    //     //   }
    //     // });
    //   }),
    //   borderData: FlBorderData(
    //     show: false,
    //   ),
    //   sectionsSpace: 0,
    //   //  centerSpaceRadius: 40,
    //   centerSpaceRadius: 50,
    //   sections: showSections(reqData),
    // ),
    // );
  }
}
