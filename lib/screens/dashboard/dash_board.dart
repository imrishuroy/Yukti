import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yukti/widgets/app_drawer.dart';
import 'widgets/dash_board_cards.dart';
import 'widgets/todays_lectures.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  drawer: Drawer(),
      drawer: const AppDrawer(),
      backgroundColor: Colors.black45,
      //backgroundColor: Color.fromRGBO(25, 23, 37, 1),
      // backgroundColor: Colors.grey.shade900,
      //backgroundColor: Color(0xff082032),

      //  backgroundColor: Color.fromRGBO(25, 23, 37, 1),

      //backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        // leading: SizedBox(
        //   height: 10.0,
        //   width: 10.0,
        //   child: Image.network(
        //       'https://cdn-icons-png.flaticon.com/512/812/812847.png'),
        // ),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              FontAwesomeIcons.alignLeft,
              size: 27.0,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        elevation: 0.0,
        // backgroundColor: Color.fromRGBO(40, 200, 253, 1),
        // backgroundColor: Color.fromRGBO(29, 38, 40, 1),
        //  backgroundColor: Color.fromRGBO(25, 23, 37, 1),
        backgroundColor: Colors.black45,

        //automaticallyImplyLeading: false,
        //   backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        // backgroundColor: Color(0XFF00286E),
        centerTitle: true,
        title: const Text(
          'DashBoard',
          style: TextStyle(
            letterSpacing: 1.2,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          CircleAvatar(
            radius: 22.3,
            backgroundColor: Colors.deepOrange,
            child: CircleAvatar(
              radius: 19.5,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://raw.githubusercontent.com/imrishuroy/Rishu-Portfolio/master/assets/avtar.png'),
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.message),
          //   onPressed: () {
          //     // Navigator.pushNamed(
          //     //   context,
          //     //   AttendanceScreen3.routeName,
          //     //   // NewAttendanceScreen.routeName,
          //     //   // arguments: database,
          //     // );
          //   },
          // ),
          SizedBox(width: 17.0),
        ],
      ),
      body: Column(
        children: const [
          DashBoardCards(),
          // SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Text(
              'Today\'s Lectures',
              style: TextStyle(
                fontSize: 19.9,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                //color: Colors.white,
                color: Color(0xff51DACF),
                //color: Color.fromRGBO(255, 203, 0, 1),
              ),
            ),
          ),

          TodaysLectures(),
          SizedBox(height: 17.0)
        ],
      ),
    );
  }
}

// 479
