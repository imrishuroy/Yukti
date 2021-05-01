import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OneSubjectPieChart extends StatefulWidget {
  final int? attendance;
  final Color? chartColor;

  const OneSubjectPieChart({
    Key? key,
    this.attendance,
    this.chartColor: Colors.blue,
  }) : super(key: key);
  @override
  _OneSubjectPieChartState createState() => _OneSubjectPieChartState();
}

class _OneSubjectPieChartState extends State<OneSubjectPieChart> {
  int touchedIndex = 1;
  List<PieChartSectionData> showingSections() {
    return List.generate(
      2,
      (i) {
        final isTouched = i == touchedIndex;
        final double fontSize = isTouched ? 25 : 18;

        //final double radius = isTouched ? 50 : 60;
        //final double radius = isTouched ? 47 : 62;
        final double radius = isTouched ? 25 : 42;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: widget.chartColor,
              value: widget.attendance!.toDouble(),
              title: '${widget.attendance}%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );
          case 1:
            return PieChartSectionData(
              //color: Color(0xfff2edd7),
              //color: Color(0xfffbecec),
              color: Colors.black45,
              value: 100 - (widget.attendance)!.toDouble(),
              title: '',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff)),
            );

          default:
            return PieChartSectionData();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
          setState(() {
            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                pieTouchResponse.touchInput is FlPanEnd) {
              touchedIndex = -1;
            } else {
              touchedIndex = pieTouchResponse.touchedSectionIndex;
            }
          });
        }),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 20,
        sections: showingSections(),
      ),
    );
  }
}

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// const List<Color> color = [
//   Color(0xff845bef),
//   Color(0xff0293ee),
//   Color(0xfff8b400),
//   Color(0xff13d38e),
//   Color(0xffd2e603),
// ];

// class OneSubjectPieChart extends StatefulWidget {
//   final List? attendanceList;

//   const OneSubjectPieChart({Key? key, this.attendanceList}) : super(key: key);
//   @override
//   _OneSubjectPieChartState createState() => _OneSubjectPieChartState();
// }

// class _OneSubjectPieChartState extends State<OneSubjectPieChart> {
//   int? touchedIndex = 0;

//   List<PieChartSectionData> showSections(int touchIndex) {
//     //return PieData.data
//     return widget.attendanceList!
//         .asMap()
//         .map<int, PieChartSectionData>((index, data) {
//           final isTouched = index == touchIndex;
//           final double fontSize = isTouched ? 25 : 16;
//           final double radius = isTouched ? 60 : 50;
//           final value = PieChartSectionData(
//             // color: data.color,
//             color: color[index],
//             // value: data.percent,
//             value: (widget.attendanceList?[index]['attendance']).toDouble(),
//             // value: 10.0,
//             radius: radius,
//             // title: '${data.percent}%',
//             title: '${widget.attendanceList?[index]['attendance']}%',
//             titleStyle: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.bold,
//               color: Color(0xffffffff),
//             ),
//           );
//           return MapEntry(index, value);
//         })
//         .values
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //print(widget.attendanceList);
//     List<int> allAttendance = [];
//     List<int> newList = [];

//     for (var item in widget.attendanceList!) {
//       allAttendance.add(item['attendance']);
//       newList.add(item['attendance']);
//     }
//     print('All Attendance $allAttendance');
//     //  newList = allAttendance;
//     print('New List $newList');
//     newList.sort();
//     // allAttendance.sort();
//     // print(allAttendance.last);
//     print('All List $allAttendance');

//     print('New List $newList');
//     print(allAttendance.indexOf(newList.last));
//     int reqData = allAttendance.indexOf(newList.last);
//     //  print(allAttendance);

//     return PieChart(
//       PieChartData(
//         pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
//           // setState(() {
//           // setState(() {
//           //   touchedIndex = reqData;
//           // });

//           //   touchedIndex = newList.last;
//           // });
//           setState(() {
//             if (pieTouchResponse.touchInput is FlLongPressEnd ||
//                 pieTouchResponse.touchInput is FlPanEnd) {
//               touchedIndex = reqData;
//             } else {
//               // touchedIndex = pieTouchResponse.touchedSectionIndex;
//               touchedIndex = reqData;
//             }
//           });
//         }),
//         borderData: FlBorderData(
//           show: false,
//         ),
//         sectionsSpace: 0,
//         //  centerSpaceRadius: 40,
//         centerSpaceRadius: 50,
//         sections: showSections(reqData),
//       ),
//     );
//   }
// }
