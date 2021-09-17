import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yukti/screens/attendance/attendance_screen.dart';
import '/screens/assignments/assignments_screen.dart';
import '/screens/lectures/lectures_selection.dart';
import '/screens/announcements/announcements_screen.dart';

class DashBoardCards extends StatelessWidget {
  const DashBoardCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _dashBoardCards = [
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
    ];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimationLimiter(
            child: GridView.builder(
          itemCount: _dashBoardCards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              columnCount: _dashBoardCards.length,
              position: index,
              duration: const Duration(milliseconds: 375),
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: _dashBoardCards[index],
                ),
              ),
            );
          },
        )

            // GridView.count(
            //   childAspectRatio: 1.3,
            //   crossAxisCount: 2,
            //   children: [

            //   ],
            // ),
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
            gradient: const LinearGradient(
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
                    style: const TextStyle(
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
