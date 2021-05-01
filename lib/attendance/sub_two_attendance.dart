import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:yukti/models/attendance_model.dart';
import 'package:yukti/widgets/one_subject_piechart.dart';

class SubjectTwoAttendance extends StatefulWidget {
  @override
  _SubjectTwoAttendanceState createState() => _SubjectTwoAttendanceState();
}

class _SubjectTwoAttendanceState extends State<SubjectTwoAttendance> {
  bool _isLoading = false;
  int? totalAttendane = 0;

  List<AttendanceModel> attendance = <AttendanceModel>[];

  List<AttendanceModel> subjectOne = <AttendanceModel>[];

  //List<Map> subjects = [];
  List<AttendanceModel> currentSubject = [];
  String subjectName = '';
  int totalClassHeld = 0;
  int totalClassAttended = 0;

  void getAttendance() async {
    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse(
        'https://script.googleusercontent.com/macros/echo?user_content_key=kcXleL4SElggrYik2RIg81y0mlJz0Rxj12RlywCrvroMHlYnCydKj2i6Bl2D2ItzxVNulFJJBPEe93OrST4anzxgHcVKBviTm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnJCEyGutd5rIS1s8kI1wPPlLtGZuAHqUH8pu6TAD50rc7kZFjPdIbd-6v1UQAZ2hb9DQOKXDWWUbSmpNx2BGQtEs2lSl6vDkjNz9Jw9Md8uu&lib=MF1IRVQUPyWVqLuWo5ZKf7wMz0pnu8441');

    var response = await http.get(url);

    List jsonFeedback = convert.jsonDecode(response.body);
    subjectName = jsonFeedback[0]['sn_no'];
    totalClassHeld = jsonFeedback[0]['total_attendance'];
    jsonFeedback.removeAt(0);

    jsonFeedback.forEach((element) {
      AttendanceModel attendanceModel = AttendanceModel();
      if (element['enrollment_no'] == '0105CS191091') {
        attendanceModel.name = element['name'];
        attendanceModel.enrollNo = element['enrollment_no'];
        attendanceModel.totalAttendance = element['total_attendance'];
        // currentSubject.add(attendanceModel);
        totalClassAttended = attendanceModel.totalAttendance!;
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (totalClassAttended == 0) {
      totalAttendane = 0;
    } else {
      totalAttendane = ((totalClassAttended / totalClassHeld) * 100).round();
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'CS402',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () => getAttendance(),
              child: Text(
                'Get',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 100.0),
        _isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : OneSubjectPieChart(
                attendance: totalAttendane,
                // chartColor: Color.fromRGBO(0, 141, 82, 1),
                chartColor: Color(0xff16c79a),
              ),
      ],
    );
  }
}
