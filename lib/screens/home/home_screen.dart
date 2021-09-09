import 'package:admin_yukti/screens/assignments/assignment_selection.dart';
import 'package:admin_yukti/screens/attendance/attendance_selection.dart';
import 'package:admin_yukti/screens/lectures/lectures_selection.dart';
import 'package:admin_yukti/screens/widgets/option_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) {
        return const HomeScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
            const SizedBox(width: 20.0)
          ],
          backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
          centerTitle: true,
          title: const Text('Admin Panel'),
        ),
        body: Center(
          child: SizedBox(
            height: 500.0,
            width: 500.0,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
              childAspectRatio: 1.3,
              children: <Widget>[
                OptionCard(
                  title: 'Announcements',
                  icon: FontAwesomeIcons.bell,
                  onTap: () {
                    //  Navigator.pushNamed(context, AnnouncemetScreen.routeName);
                  },
                ),
                OptionCard(
                    title: 'Attendence',
                    icon: FontAwesomeIcons.calendarCheck,
                    onTap: () => Navigator.of(context)
                        .pushNamed(AttendanceSelection.routeName)),
                OptionCard(
                    title: 'Assignments',
                    icon: FontAwesomeIcons.clipboardList,
                    onTap: () => Navigator.of(context)
                        .pushNamed(AssignmentSelection.routeName)),
                OptionCard(
                  title: 'Lectures',
                  icon: FontAwesomeIcons.book,
                  onTap: () => Navigator.of(context)
                      .pushNamed(LectureSelection.routeName),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
