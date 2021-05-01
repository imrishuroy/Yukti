import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:url_launcher/url_launcher.dart';

abstract class Utility {
  Future<void> launchInBrowser(String url);
  void showSnackBar({BuildContext? context});
  // void getAttendance(
  //     {String? subjectName, int? totalClassHeld, int? totalClassAttended});
}

class UtilityFunctions implements Utility {
  @override
  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void showSnackBar({BuildContext? context}) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'No file available',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            letterSpacing: 1.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // @override
  // void getAttendance(
  //     {String? subjectName,
  //     int? totalClassHeld,
  //     int? totalClassAttended}) async {
  //   // setState(() {
  //   //   _isLoading = true;
  //   // });

  //   var url = Uri.parse(
  //       'https://script.googleusercontent.com/macros/echo?user_content_key=bcRBfUvS6-zaxOK25ziqk1JdvGOW0S2npqbdyk5L05a12YwVQFO2VivrIfZKps_utq_Sxu5XWxM5opznckRITpMiQhT_ljYfm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnIrr7AD1kDdWsnCLvVUDN_IYBkN0pTYImHmhKjYQ1RMslJysqyxdsS2WuUpLkZO0VR1RNf1Vcw8c--JOz4nXxNZWmITZWfXDtw&lib=MsvI444TSp283wZTVBAU2SnImAf41yL87');

  //   var response = await http.get(url);

  //   List jsonFeedback = convert.jsonDecode(response.body);
  //   subjectName = jsonFeedback[0]['sn_no'];
  //   totalClassHeld = jsonFeedback[0]['total_attendance'];
  //   jsonFeedback.removeAt(0);

  //   jsonFeedback.forEach((element) {
  //     AttendanceModel attendanceModel = AttendanceModel();
  //     if (element['enrollment_no'] == '0105CS191091') {
  //       attendanceModel.name = element['name'];
  //       attendanceModel.enrollNo = element['enrollment_no'];
  //       attendanceModel.totalAttendance = element['total_attendance'];
  //       // currentSubject.add(attendanceModel);
  //       totalClassAttended = attendanceModel.totalAttendance!;
  //     }
  //   });

  //   // setState(() {
  //   //   _isLoading = false;
  //   // });
  // }
}
