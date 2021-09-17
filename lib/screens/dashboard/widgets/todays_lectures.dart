import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:provider/provider.dart';
import 'package:yukti/blocs/bloc/auth_bloc.dart';
import 'package:yukti/models/app_user.dart';
import 'package:yukti/models/lecture.dart';
import 'package:yukti/respositories/lectures/lectures_repository.dart';
import 'package:yukti/respositories/user/user_repository.dart';

class TodaysLectures extends StatefulWidget {
  const TodaysLectures({Key? key}) : super(key: key);

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
    // String day = DateFormat.EEEE().format(date!);

    String day = 'Thursday';
    //  UtilityFunctions utility = UtilityFunctions();
    //  print(day);

    return Expanded(
      child: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 20.0),
                Expanded(
                  child: FutureBuilder<List<Lecture?>>(
                    future: _lectureRepo.getWeekDayLecture(
                      branch: _branch,
                      sem: _sem,
                      section: _section,
                      day: day,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      print('Lecture ${snapshot.data}');
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'Nothing Here :)',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        );
                      }
                      return AnimationLimiter(
                        child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final lecture = snapshot.data?[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 10.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${lecture?.subName} - ${lecture?.subCode}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0,
                                                    letterSpacing: 1.2,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  'Prof. ${lecture?.profName}',
                                                  style: TextStyle(
                                                    color: Colors.grey.shade300,
                                                    letterSpacing: 1.2,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                const SizedBox(height: 8.0),
                                                Text(
                                                  '⏰ ${lecture?.time}',
                                                  style: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Container(
                                            //   height: 30.0,
                                            //   width: 60.0,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(10.0),
                                            //     gradient: LinearGradient(
                                            //       begin: Alignment.topLeft,
                                            //       end: Alignment.bottomRight,
                                            //       colors: [
                                            //         Color.fromRGBO(40, 200, 253, 1),
                                            //         Colors.white,

                                            //         // Colors.blue,
                                            //       ],
                                            //     ),
                                            //   ),
                                            //   child: Text(
                                            //     'Join',
                                            //     style: TextStyle(
                                            //       color: Colors.white,
                                            //       fontSize: 15.0,
                                            //       letterSpacing: 1.0,
                                            //       fontWeight: FontWeight.w600,
                                            //     ),
                                            //   ),
                                            // ),

                                            const Chip(
                                              backgroundColor: Color.fromRGBO(
                                                  40, 200, 253, 1),
                                              label: Text(
                                                'Join',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  letterSpacing: 1.2,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 9.0),
                                        SizedBox(
                                          width: 400.0,
                                          height: 1.0,
                                          child: Divider(
                                            color: Colors.grey.shade400,
                                          ),
                                        )
                                      ],
                                    ),

                                    // ListTile(
                                    //   title: Text(
                                    //     '${lecture?.subName} - ${lecture?.subCode}',
                                    //     style: TextStyle(
                                    //       color: Colors.white,
                                    //       fontSize: 16.0,
                                    //     ),
                                    //   ),
                                    //   subtitle: Column(
                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: [
                                    //       Text(
                                    //         '${lecture?.profName}',
                                    //         style: TextStyle(
                                    //           color: Colors.grey,
                                    //           fontSize: 16.0,
                                    //         ),
                                    //       ),
                                    //       Text(
                                    //         '${lecture?.time}',
                                    //         style: TextStyle(
                                    //           color: Colors.grey,
                                    //           fontSize: 16.0,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    //   trailing: Chip(
                                    //     backgroundColor: Colors.blue,
                                    //     label: Text(
                                    //       'Join',
                                    //       style: TextStyle(
                                    //         color: Colors.white,
                                    //         fontSize: 15.0,
                                    //         letterSpacing: 1.0,
                                    //         fontWeight: FontWeight.w600,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),

                                    //  Card(
                                    //   color: Color.fromRGBO(255, 255, 250, 1),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //       horizontal: 20.0,
                                    //       vertical: 10.0,
                                    //     ),
                                    //     child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         //  Text('${lectures[index]['sub-code']}'),

                                    //         Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.spaceBetween,
                                    //           children: [
                                    //             Text(
                                    //               '${lecture?.subCode ?? ''}',
                                    //               style: TextStyle(
                                    //                 fontWeight: FontWeight.w600,
                                    //               ),
                                    //             ),
                                    //             Container(
                                    //               alignment: Alignment.bottomCenter,
                                    //               child: GestureDetector(
                                    //                 onTap: () {
                                    //                   // utility.launchInBrowser(
                                    //                   //     '${today[index]['link']}');
                                    //                 },
                                    //                 child: Text(
                                    //                   'Join',
                                    //                   style: TextStyle(
                                    //                     color: Colors.blue,
                                    //                     fontSize: 18.0,
                                    //                     letterSpacing: 1.0,
                                    //                     fontWeight: FontWeight.bold,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //         SizedBox(height: 2.0),
                                    //         Text(
                                    //           '${lecture?.subName ?? 'N/A'}',
                                    //           style: TextStyle(fontSize: 17.5),
                                    //         ),
                                    //         SizedBox(height: 2.0),
                                    //         Text(
                                    //           '${lecture?.time ?? ''}',
                                    //           style: TextStyle(
                                    //             color: Colors.grey[800],
                                    //           ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:provider/provider.dart';
// import 'package:yukti/blocs/bloc/auth_bloc.dart';
// import 'package:yukti/models/app_user.dart';
// import 'package:yukti/models/lecture.dart';
// import 'package:yukti/respositories/lectures/lectures_repository.dart';
// import 'package:yukti/respositories/user/user_repository.dart';

// class TodaysLectures extends StatefulWidget {
//   @override
//   _TodaysLecturesState createState() => _TodaysLecturesState();
// }

// class _TodaysLecturesState extends State<TodaysLectures> {
//   DateTime? date = DateTime.now();

//   String? _branch;
//   String? _sem;
//   String? _section;
//   bool? _isLoading;

//   @override
//   void initState() {
//     super.initState();
//     getCurrentUserData();
//   }

//   getCurrentUserData() async {
//     setState(() {
//       _isLoading = true;
//     });
//     final userRepo = context.read<UserRepository>();
//     final userId = context.read<AuthBloc>().state.user?.uid;

//     AppUser? user = await userRepo.getUserById(userId: userId);

//     _branch = user?.branch;
//     _sem = user?.sem;
//     _section = user?.section;

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _lectureRepo = context.read<LecturesRepository>();
//     String day = DateFormat.EEEE().format(date!);
//     //  UtilityFunctions utility = UtilityFunctions();
//     //  print(day);

//     return Expanded(
//       child: _isLoading == true
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 SizedBox(height: 10.0),
//                 Expanded(
//                   child: FutureBuilder<List<Lecture?>>(
//                     future: _lectureRepo.getWeekDayLecture(
//                       branch: _branch,
//                       sem: _sem,
//                       section: _section,
//                       day: day,
//                     ),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       }

//                       print('Lecture ${snapshot.data}');
//                       if (snapshot.data?.length == 0) {
//                         return Center(
//                           child: Text(
//                             'Nothing Here :)',
//                             style: TextStyle(fontSize: 20.0),
//                           ),
//                         );
//                       }
//                       return ListView.builder(
//                           itemCount: snapshot.data?.length,
//                           itemBuilder: (context, index) {
//                             final lecture = snapshot.data?[index];
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 7.0,
//                                 vertical: 7.0,
//                               ),
//                               child: Card(
//                                 color: Color.fromRGBO(255, 255, 250, 1),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 20.0,
//                                     vertical: 10.0,
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       //  Text('${lectures[index]['sub-code']}'),

//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             '${lecture?.subCode ?? ''}',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           Container(
//                                             alignment: Alignment.bottomCenter,
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 // utility.launchInBrowser(
//                                                 //     '${today[index]['link']}');
//                                               },
//                                               child: Text(
//                                                 'Join',
//                                                 style: TextStyle(
//                                                   color: Colors.blue,
//                                                   fontSize: 18.0,
//                                                   letterSpacing: 1.0,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 2.0),
//                                       Text(
//                                         '${lecture?.subName ?? 'N/A'}',
//                                         style: TextStyle(fontSize: 17.5),
//                                       ),
//                                       SizedBox(height: 2.0),
//                                       Text(
//                                         '${lecture?.time ?? ''}',
//                                         style: TextStyle(
//                                           color: Colors.grey[800],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           });
//                     },
//                   ),
//                 ),
              
//               ],
//             ),
//     );
//   }
// }

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
