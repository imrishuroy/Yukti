import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yukti/blocs/bloc/auth_bloc.dart';
import 'package:yukti/models/app_user.dart';
import 'package:yukti/respositories/firebase/firebase_repositroy.dart';
import 'package:yukti/respositories/user/user_repository.dart';
import 'package:yukti/screens/attendance/pie_chat2.dart';
import 'package:yukti/screens/attendance/sub_attendance_tile.dart';
import 'package:yukti/widgets/nothing_here.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'attendance_pie_chart.dart';
import 'attendance_tile.dart';
import 'pie_char_sample_1.dart';
import 'pie_chat3.dart';

const List<Color> color = [
  Color(0xff845bef),
  Color(0xff0293ee),
  Color(0xfff8b400),
  Color(0xff13d38e),
  Color(0xffd2e603),
];

class AttendanceScreen extends StatelessWidget {
  static const String routeName = '/attendance';

  static Route route() {
    return PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (context, _, __) {
          return AttendanceScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    final _userId = context.read<AuthBloc>().state.user?.uid;
    final _userRepo = context.read<UserRepository>();
    final _firebaseRepo = context.read<FirebaseRepositroy>();

    return FutureBuilder<AppUser?>(
        future: _userRepo.getUserById(userId: _userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return NothingHere(
              appBarTitle: 'Attendance',
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Color.fromRGBO(29, 38, 40, 1),
              body: Center(
                child: CircularProgressIndicator(),
              ),
              // body: Image.asset('assets/loader.gif'),
            );
          }

          // checks weather user has added their profile
          AppUser? user = snapshot.data;

          return StreamBuilder<DocumentSnapshot?>(
            stream: _firebaseRepo.attendaceStream(
              branch: user?.branch,
              sem: user?.sem,
              enrollNo: user?.enrollNo,
            ),
            // stream: _firebaseRepo.attendaceStream

            //   branch: user.branch,
            //   sem: user.sem,
            //   enrollNo: user.enrollNo,
            // ),
            builder: (BuildContext context, attendanceSnapshot) {
              if (attendanceSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: Color.fromRGBO(29, 38, 40, 1),
                  body:
                      // Center(
                      //   child: Container(
                      //     height: 80.0,
                      //     width: 70.0,
                      //     child: Image.asset('assets/loader.gif'),
                      //   ),
                      // ),
                      Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final data = attendanceSnapshot.data?.data() as Map?;
              final List? attendanceList = data?['attendance'];
              final totalAttendance = data?['totalAttendance'];
              final lastUpdated = data?['lastUpdated'];
              // print(attendance);
              final int? lenghtOfAttendance = attendanceList?.length;
              //  print('Assignment Length $lenghtOfAttendance');
              if (lenghtOfAttendance == null ||
                  lenghtOfAttendance == 0 ||
                  totalAttendance == null ||
                  lastUpdated == '') {
                return NothingHere(
                  appBarTitle: 'Attendance',
                );
              }
              return Scaffold(
                backgroundColor: Color.fromRGBO(29, 38, 40, 1),
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(0, 141, 82, 1),
                  centerTitle: true,
                  title: Text('Attendance - ${user?.name}'),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(15.0),
                    child: Column(
                      children: [
                        Text(
                          '${user?.enrollNo}',
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
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 15.0),
                      DisplayTotalAttendanceCard(
                        totalAttendance: data?['totalAttendance'],
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'As on ${data?['lastUpdated']}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 120.0),
                      // PieChartSample1(),
                      //PieChartSample2(),

                      // AttendancePieChart(attendanceList: attendanceList),
                      AttendancePieChartOld(attendanceList: attendanceList),
                      SizedBox(height: 150),
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: attendanceList?.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SubjectAttendanceTileOld(
                                  subCode:
                                      '${attendanceList?[index]['subCode']}',
                                  subName:
                                      '${attendanceList?[index]['subName']}',
                                  facultyName:
                                      '${attendanceList?[index]['faculty']}',
                                  color: color[index],
                                ),
                                SizedBox(height: 10.0),
                              ],
                            );
                          },
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.error, color: Colors.red),
                        label: Text(
                          'Report Error',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
