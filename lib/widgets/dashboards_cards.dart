import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:yukti/services/database_service.dart';

import 'onecard.dart';

class DashBoardCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final DataBase database = Provider.of<DataBase>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          Expanded(
            child: GridView.count(
              //  childAspectRatio: 1.28,
              childAspectRatio: height < 750 ? 1.5 : 1.28,
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              crossAxisCount: 2,
              children: [
                OneCard(
                  title: 'Announcements',
                  icon: FontAwesomeIcons.bell,
                  onTap: () {
                    // Navigator.pushNamed(context, AnnouncemetScreen.routeName,
                    //     arguments: database);
                  },
                ),
                OneCard(
                  title: 'Attendence',
                  icon: FontAwesomeIcons.calendarCheck,
                  onTap: () {
                    // Navigator.pushNamed(context, AttendanceScreen.routeName,
                    //     arguments: database);
                    // Navigator.pushNamed(
                    //   context,
                    //   NewAttendanceScreen.routeName,
                    //   arguments: database,
                    // );
                  },
                ),
                OneCard(
                  title: 'Assignments',
                  icon: FontAwesomeIcons.clipboardList,
                  onTap: () {
                    // Navigator.pushNamed(context, AssignmentScreen.routeName,
                    //     arguments: database);
                  },
                ),
                OneCard(
                  title: 'Lectures',
                  icon: FontAwesomeIcons.book,
                  onTap: () {},
                  // onTap: () => Navigator.pushNamed(
                  //   context,
                  //   LectureSelection.routeName,
                  // ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
