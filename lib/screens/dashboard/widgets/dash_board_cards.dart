import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashBoardCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          childAspectRatio: 1.2,
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
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Card(
        // color: Color.fromRGBO(255, 255, 250, 1),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height < 750 ? 20.0 : 30.0),
            Icon(icon, size: height < 750 ? 30.0 : 40),
            SizedBox(height: 12.0),
            Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: height < 750 ? 15.0 : 30.0),
          ],
        ),
      ),
    );
  }
}
