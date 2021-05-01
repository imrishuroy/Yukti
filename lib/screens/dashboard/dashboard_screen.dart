import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yukti/services/database_service.dart';
import 'package:yukti/widgets/app_drawer.dart';
import 'package:yukti/widgets/dashboards_cards.dart';
import 'package:yukti/widgets/todays_lectures.dart';

class DashBoard extends StatelessWidget {
  static const String routeName = '/dashboard-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => DashBoard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final FireStoreDataBase database =
    //     Provider.of<FireStoreDataBase>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
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
          // TodaysLectures(
          //   database: database,
          // ),
        ],
      ),
    );
  }
}

// 479
