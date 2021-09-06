import 'package:flutter/material.dart';
import 'widgets/dash_board_cards.dart';
import 'widgets/todays_lectures.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      //  drawer: AppDrawer(),
      backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text('DashBoard'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.message,
            ),
            onPressed: () {
              // Navigator.pushNamed(
              //   context,
              //   AttendanceScreen3.routeName,
              //   // NewAttendanceScreen.routeName,
              //   // arguments: database,
              // );
            },
          ),
          SizedBox(width: 7.0),
        ],
      ),
      body: Column(
        children: [
          DashBoardCards(),
          // SizedBox(height: 10.0),
          TodaysLectures(),
        ],
      ),
    );
  }
}

// 479
