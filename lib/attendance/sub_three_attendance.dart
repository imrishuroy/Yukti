import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:yukti/models/attendance_model.dart';
import 'package:yukti/widgets/one_subject_piechart.dart';

class SubjectThreeAttendance extends StatefulWidget {
  @override
  _SubjectThreeAttendanceState createState() => _SubjectThreeAttendanceState();
}

class _SubjectThreeAttendanceState extends State<SubjectThreeAttendance> {
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
        'https://script.googleusercontent.com/macros/echo?user_content_key=bcRBfUvS6-zaxOK25ziqk1JdvGOW0S2npqbdyk5L05a12YwVQFO2VivrIfZKps_utq_Sxu5XWxM5opznckRITpMiQhT_ljYfm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnIrr7AD1kDdWsnCLvVUDN_IYBkN0pTYImHmhKjYQ1RMslJysqyxdsS2WuUpLkZO0VR1RNf1Vcw8c--JOz4nXxNZWmITZWfXDtw&lib=MsvI444TSp283wZTVBAU2SnImAf41yL87');

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
              'CS403',
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
                //chartColor: Color.fromRGBO(0, 141, 82, 1),
                chartColor: Color(0xffff7171),
              ),
      ],
    );
  }
}
