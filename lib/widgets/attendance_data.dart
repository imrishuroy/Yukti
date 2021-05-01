import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

import 'package:yukti/models/attendance_model.dart';
import 'package:yukti/widgets/attendance_pie_chart.dart';
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

class AttendanceData extends StatefulWidget {
  final String? name;
  final String? enrollNo;

  const AttendanceData({
    Key? key,
    this.name,
    this.enrollNo,
  }) : super(key: key);
  @override
  _AttendanceDataState createState() => _AttendanceDataState();
}

class _AttendanceDataState extends State<AttendanceData> {
  bool _isLoading = false;

  List<AttendanceModel> attendance = <AttendanceModel>[];

  // List<AttendanceModel> sub5 = <AttendanceModel>[];
  List<AttendanceModel> allSubjects = <AttendanceModel>[];
  // List subjectsName = [];
  List<Map> subjects = [];
  int totalClass = 0;
  int totalClassAttended = 0;

  bool isLoading = false;
  @override
  void initState() {
    getAttendance();
    super.initState();
  }

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
        if (element['enrollment_no'] == widget.enrollNo) {
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

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('All Subjects $subjects');
    // print(allSubjects.length);
    // print(subjectsName);
    for (int i = 0; i < allSubjects.length; i++) {
      print('Attendance ${allSubjects[i].totalAttendance}');
    }

    //   print('All Subjects Attendance $allSubjects);
    for (int i = 0; i < subjects.length; i++) {
      totalClass += subjects[i]['totalClass'] as int;
      totalClassAttended += allSubjects[i].totalAttendance!;
    }
    print('Total Class - $totalClass');
    print('Total Class Attended - $totalClassAttended');
    return Scaffold(
      backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text('Attendance - ${widget.name}'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15.0),
          child: Column(
            children: [
              Text(
                '${widget.enrollNo}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 15.0)
            ],
          ),
        ),
      ),
      body: _isLoading == true
          // ? Center(
          //     child: CircularProgressIndicator(),
          //   )
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80.0,
                    width: 90,
                    child: Image.asset(
                      'assets/loader.gif',
                      //fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Text(
                    'Please wait a moment...',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Color.fromRGBO(255, 203, 0, 1),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                SizedBox(height: 10.0),
                DisplayTotalAttendanceCard(
                  totalAttendance:
                      ((totalClassAttended / totalClass) * 100).round(),
                ),
                SizedBox(height: 10.0),
                Text(
                  'As on 24/03/21',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 120.0),
                AttendancePieChart(
                    attendanceList: allSubjects, subjects: subjects),
                SizedBox(height: 150),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      return SubjectAttendanceTile(
                        subCode: subjects[index]['name'],
                        // subName: subjects[index]['name'],

                        color: color[index],
                      );
                    },
                  ),
                ),
                SizedBox(height: 150),
              ],
            ),
    );
  }
}

// return Row(
//   children: [
//     Text('${subjects[index]['name']}'),
//     Text(' -  '),
//     Text('${allSubjects[index].totalAttendance}'),
//     Text(
//       'Total Attencance : ${subjects[index]['totalAttendance']}',
//     ),
//   ],
// );
