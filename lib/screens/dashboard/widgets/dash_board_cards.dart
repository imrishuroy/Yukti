import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yukti/screens/attendance/attendance_screen.dart';
import '/screens/assignments/assignments_screen.dart';
import '/screens/lectures/lectures_selection.dart';
import '/screens/announcements/announcements_screen.dart';

class DashBoardCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          childAspectRatio: 1.3,
          crossAxisCount: 2,
          children: [
            OneCard(
              title: 'Announcements',
              icon: FontAwesomeIcons.bell,
              onTap: () {
                Navigator.pushNamed(context, AnnouncemetScreen.routeName);
              },
            ),
            OneCard(
              title: 'Attendence',
              icon: FontAwesomeIcons.calendarCheck,
              onTap: () {
                Navigator.pushNamed(context, AttendanceScreen.routeName);
              },
            ),
            OneCard(
              title: 'Assignments',
              icon: FontAwesomeIcons.clipboardList,
              onTap: () {
                Navigator.pushNamed(context, AssignmentsScreen.routeName);
              },
            ),
            OneCard(
              title: 'Lectures',
              icon: FontAwesomeIcons.book,
              onTap: () => Navigator.pushNamed(
                context,
                LectureSelection.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OneCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
//  final String? count;
  final Function? onTap;

  const OneCard({
    Key? key,
    this.title,
    this.icon,
    //  this.count,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //  final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        // color: Color.fromRGBO(40, 200, 253, 1),
        // color: Color.fromRGBO(255, 255, 250, 1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(40, 200, 253, 1),
                Colors.white,

                // Colors.blue,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //  SizedBox(height: height < 750 ? 10.0 : 20.0),
              Column(
                children: [
                  Icon(icon, size: 35),
                  const SizedBox(height: 13.0),
                  Text(
                    '$title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              //SizedBox(height: 12.0),

              //  SizedBox(height: height < 750 ? 10.0 : 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
