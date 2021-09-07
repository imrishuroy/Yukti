import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:yukti/blocs/bloc/auth_bloc.dart';
import 'package:yukti/models/app_user.dart';
import 'package:yukti/models/lecture.dart';
import 'package:yukti/respositories/lectures/lectures_repository.dart';
import 'package:yukti/respositories/user/user_repository.dart';

class TodaysLectures extends StatefulWidget {
  @override
  _TodaysLecturesState createState() => _TodaysLecturesState();
}

class _TodaysLecturesState extends State<TodaysLectures> {
  DateTime? date = DateTime.now();

  String? _branch;
  String? _sem;
  String? _section;
  bool? _isLoading;

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  getCurrentUserData() async {
    setState(() {
      _isLoading = true;
    });
    final userRepo = context.read<UserRepository>();
    final userId = context.read<AuthBloc>().state.user?.uid;

    AppUser? user = await userRepo.getUserById(userId: userId);

    _branch = user?.branch;
    _sem = user?.sem;
    _section = user?.section;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _lectureRepo = context.read<LecturesRepository>();
    String day = DateFormat.EEEE().format(date!);
    //  UtilityFunctions utility = UtilityFunctions();
    //  print(day);

    return Expanded(
      child: _isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'Today\'s Lectures',
                    style: TextStyle(
                      fontSize: 19.9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Color.fromRGBO(255, 203, 0, 1),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: FutureBuilder<List<Lecture?>>(
                    future: _lectureRepo.getWeekDayLecture(
                        branch: _branch,
                        sem: _sem,
                        section: _section,
                        day: day),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.data?.length == 0) {
                        return Center(
                          child: Text(
                            'Nothing Here :)',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final lecture = snapshot.data?[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 7.0,
                              ),
                              child: Card(
                                color: Color.fromRGBO(255, 255, 250, 1),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //  Text('${lectures[index]['sub-code']}'),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${lecture?.subCode ?? ''}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: GestureDetector(
                                              onTap: () {
                                                // utility.launchInBrowser(
                                                //     '${today[index]['link']}');
                                              },
                                              child: Text(
                                                'Join',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18.0,
                                                  letterSpacing: 1.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        '${lecture?.subName ?? 'N/A'}',
                                        style: TextStyle(fontSize: 17.5),
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        '${lecture?.time ?? ''}',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
                // Expanded(
                //   child: FutureBuilder<DocumentSnapshot>(
                //     future: appDataBase.getLecturesData(
                //         branch: _branch, sem: _sem, section: _section),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasError) {
                //         return Center(child: Text('Something went wrong'));
                //       }
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return
                //             // Center(
                //             //   child: Container(
                //             //     height: 80.0,
                //             //     width: 90,
                //             //     child: Image.asset(
                //             //       'assets/loader.gif',
                //             //       //fit: BoxFit.cover,
                //             //     ),
                //             //   ),
                //             // );

                //             Center(child: CircularProgressIndicator());
                //       } else {
                //         // checking if documnet exist or not
                //         if (snapshot.data?.exists == true) {
                //           Map? data = snapshot.data?.data();
                //           if (data?.length == 0) {
                //             return Center(
                //               child: Text(
                //                 'Nothing Here :)',
                //                 style: TextStyle(fontSize: 20.0),
                //               ),
                //             );
                //           }

                //           final List? today = data?['$day'];
                //           if (today == null || today.length == 0) {
                //             return Container(
                //               height: 90.0,
                //               width: 220.0,
                //               child: Image.asset('assets/no-data-found.png'),
                //             );
                //           }
                //           return ListView.builder(
                //             itemCount: today.length,
                //             itemBuilder: (ctx, index) {
                //               return Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                   horizontal: 20.0,
                //                   vertical: 7.0,
                //                 ),
                //                 child: Card(
                //                   color: Color.fromRGBO(255, 255, 250, 1),
                //                   child: Padding(
                //                     padding: const EdgeInsets.symmetric(
                //                       horizontal: 20.0,
                //                       vertical: 10.0,
                //                     ),
                //                     child: Column(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         //  Text('${lectures[index]['sub-code']}'),

                //                         Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Text(
                //                               '${today[index]['subCode']}',
                //                               style: TextStyle(
                //                                 fontWeight: FontWeight.w600,
                //                               ),
                //                             ),
                //                             Container(
                //                               alignment: Alignment.bottomCenter,
                //                               child: GestureDetector(
                //                                 onTap: () {
                //                                   // utility.launchInBrowser(
                //                                   //     '${today[index]['link']}');
                //                                 },
                //                                 child: Text(
                //                                   'Join',
                //                                   style: TextStyle(
                //                                     color: Colors.blue,
                //                                     fontSize: 18.0,
                //                                     letterSpacing: 1.0,
                //                                     fontWeight: FontWeight.bold,
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                         SizedBox(height: 2.0),
                //                         Text(
                //                           '${today[index]['subName']}',
                //                           style: TextStyle(fontSize: 17.5),
                //                         ),
                //                         SizedBox(height: 2.0),
                //                         Text(
                //                           '${today[index]['time']}',
                //                           style: TextStyle(
                //                             color: Colors.grey[800],
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               );
                //             },
                //           );
                //         }
                //         return Container(
                //           height: 90.0,
                //           width: 220.0,
                //           child: Image.asset('assets/no-data-found.png'),
                //         );
                //       }
                //     },
                //   ),
                // )
              ],
            ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:oriental_management/data/data.dart';

// class TodaysLectures extends StatefulWidget {
//   @override
//   _TodaysLecturesState createState() => _TodaysLecturesState();
// }

// class _TodaysLecturesState extends State<TodaysLectures> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   getCurrentUserData() async {}
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20.0,
//             ),
//             child: Text(
//               'Todays Lectures',
//               style: TextStyle(
//                 fontSize: 19.9,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1.2,
//                 color: Color.fromRGBO(255, 203, 0, 1),
//               ),
//             ),
//           ),
//           SizedBox(height: 10.0),
//           Expanded(
//             child: ListView.builder(
//               itemCount: lectures.length,
//               itemBuilder: (ctx, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 7.0),
//                   child: Card(
//                     color: Color.fromRGBO(255, 255, 250, 1),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20.0,
//                         vertical: 10.0,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('${lectures[index]['sub-code']}'),
//                           Text(
//                             '${lectures[index]['lecture']}',
//                             style: TextStyle(fontSize: 17.0),
//                           ),
//                           Text('${lectures[index]['room']}')
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
