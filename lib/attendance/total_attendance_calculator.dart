import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

import 'package:yukti/models/attendance_model.dart';
import 'package:yukti/widgets/subject_attendance_tile.dart';

const List<Map<String, String>> subjectsAPI = [
  {
    // 'BT401':
    'link':
        'https://script.googleusercontent.com/macros/echo?user_content_key=bcRBfUvS6-zaxOK25ziqk1JdvGOW0S2npqbdyk5L05a12YwVQFO2VivrIfZKps_utq_Sxu5XWxM5opznckRITpMiQhT_ljYfm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnIrr7AD1kDdWsnCLvVUDN_IYBkN0pTYImHmhKjYQ1RMslJysqyxdsS2WuUpLkZO0VR1RNf1Vcw8c--JOz4nXxNZWmITZWfXDtw&lib=MsvI444TSp283wZTVBAU2SnImAf41yL87',
  },
  {
    //'CS402':
    'link':
        'https://script.googleusercontent.com/macros/echo?user_content_key=kcXleL4SElggrYik2RIg81y0mlJz0Rxj12RlywCrvroMHlYnCydKj2i6Bl2D2ItzxVNulFJJBPEe93OrST4anzxgHcVKBviTm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnJCEyGutd5rIS1s8kI1wPPlLtGZuAHqUH8pu6TAD50rc7kZFjPdIbd-6v1UQAZ2hb9DQOKXDWWUbSmpNx2BGQtEs2lSl6vDkjNz9Jw9Md8uu&lib=MF1IRVQUPyWVqLuWo5ZKf7wMz0pnu8441',
  },
  {
    // 'CS403':
    'link':
        'https://script.googleusercontent.com/macros/echo?user_content_key=K-JOKEYMaT3CBGN96R-LICOPvw9DEsjN_f0XnvjK4bWkYWwhyqBMZHRnXMLdBKNs4Z93mbbRQc6K5K8ng7lhGShzAJ1OTfF8m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnNqPB0FYNLhMs1KWNbZ-gsRWg1mKBLfieC0Ohzq2yZeki9jvd8q0mbvLoWrpo_94u2Llx1kRc6yK82y2RcVQURyTpttntIGOmw&lib=McpbRyBfCpUY4eZ2FK9GBG3ImAf41yL87',
  },
  {
    //'CS404':
    'link':
        'https://script.googleusercontent.com/macros/echo?user_content_key=HHJ5P6ckEjSJTksOXT6Bfx24yQgDL26FGqL5Ap8YOcKHa5OKGM_gOvuAHXXWWVuPAYPa6iO-IqXWZP-WQqzH2wDKLj-jLxXBm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnMScc_se17YHuQ69HPeRDfGSam7s70-Y2qHyW-XuRtGBHAyQH1DvwVZTDmNI1fRk_S0kJcklte5QOHEf69-rUb_FBbiIBh9JW9z9Jw9Md8uu&lib=MYKjS0n2xgfxvaE899cRTSgMz0pnu8441',
  },
  {
    //'CS405':
    'link':
        'https://script.googleusercontent.com/macros/echo?user_content_key=08xLKuTIvEuZzFcDku1ITm0KG5XjVt1I7mVznefHbeBHgTGoWVJyQ9oQfIagctzVJl04VX-zQ2I5opznckRITgWB4ZfyfCzlm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnKddo2tCeMwKWnhsA2O9C70w-QcHcPHY4ZskJsGmbsTdwvQ0bvrK9QoGo7KoM29fQTCwc_tYbRfGaeR4mJDWKrOB5fmIcmaYLtz9Jw9Md8uu&lib=MR3kzrlPM0ObtZURFCbFmRgMz0pnu8441'
  }
];

class DisplayTotalAttendace2 extends StatefulWidget {
  final bool? fetchAttendance;

  const DisplayTotalAttendace2({Key? key, this.fetchAttendance: false})
      : super(key: key);
  @override
  _DisplayTotalAttendace2State createState() => _DisplayTotalAttendace2State();
}

class _DisplayTotalAttendace2State extends State<DisplayTotalAttendace2> {
  bool _isLoading = false;

  List<AttendanceModel> attendance = <AttendanceModel>[];

  // List<AttendanceModel> sub5 = <AttendanceModel>[];
  List<AttendanceModel> allSubjects = <AttendanceModel>[];
  // List subjectsName = [];
  List<Map> subjects = [];
  int totalClass = 0;
  int totalClassAttended = 0;

  bool isLoading = false;

  int totalAttendance = 0;

  // @override
  // void initState() {
  //   getAttendance();
  //   super.initState();
  // }

  void getAttendance() async {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < subjectsAPI.length; i++) {
      var url = Uri.parse('${subjectsAPI[i]['link']}');
      var response = await http.get(url);
      //  print(response.body);
      List jsonFeedback = convert.jsonDecode(response.body);
      // subjectsName.add(jsonFeedback[0]['sn_no']);
      // subjects list is giving us all the subjects of user
      subjects.add(
        {
          'name': jsonFeedback[0]['sn_no'],
          'totalClass': jsonFeedback[0]['total_attendance'],
        },
      );

      // print(jsonFeedback);
      jsonFeedback.forEach((element) {
        AttendanceModel attendanceModel = AttendanceModel();
        if (element['enrollment_no'] == '0105CS191091') {
          attendanceModel.name = element['name'];
          attendanceModel.enrollNo = element['enrollment_no'];
          attendanceModel.totalAttendance = element['total_attendance'];
          // attendance.add(attendanceModel);
          allSubjects.add(attendanceModel);
        }
      });

      // AttendanceModel currentUser = attendance
      //     .firstWhere((element) => element.enrollNo == widget.enrollNo);
      // allSubjects.add(currentUser);
      //  print(currentUser.totalAttendance);
      // currentUser = null;
    }
    for (int i = 0; i < subjects.length; i++) {
      totalClass += subjects[i]['totalClass'] as int;
      totalClassAttended += allSubjects[i].totalAttendance!;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (totalClassAttended == 0) {
      totalAttendance = 0;
    } else {
      totalAttendance = ((totalClassAttended / totalClass) * 100).round();
    }

    print('Total Class - $totalClass');
    print('Total Class Attended - $totalClassAttended');
    return _isLoading == true
        ? LinearProgressIndicator()
        : totalAttendance == 0
            ? GetAttendanceCard(
                onPressed: () => getAttendance(),
              )
            : DisplayTotalAttendanceCard(
                totalAttendance: totalAttendance,
              );
  }
}

class GetAttendanceCard extends StatelessWidget {
  // final int? totalAttendance;
  final VoidCallback? onPressed;

  const GetAttendanceCard({Key? key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Attendance',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: onPressed,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.orangeAccent,
                  height: 32.0,
                  width: 63.0,
                  child: Text(
                    'Get',
                    style: TextStyle(
                      fontSize: 18.5,
                      // color: Colors.white,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
