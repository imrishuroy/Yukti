import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:yukti/services/app_database_service.dart';
import 'package:yukti/services/database_service.dart';
import 'package:yukti/services/utility_functions.dart';

class AppUser {
  final String? uid;
  final String? photUrl;
  final String? name;
  //final bool isVerified;
  final String? fatherName;
  final String? motherName;
  final String? mobileNo;
  final String? enrollNo;
  final String? branch;
  final String? sem;
  final int? attendance;
  final String? section;

  AppUser({
    required this.uid,
    this.photUrl,
    this.name,
    this.fatherName,
    this.motherName,
    this.mobileNo,
    this.enrollNo,
    this.branch,
    this.sem,
    this.attendance = 0,
    this.section,
    // this.isVerified,
  });

  // serializing our own object from firebase user class
  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
      uid: doc['id'],
      photUrl: doc['image_url'],
      name: doc['name'],
      fatherName: doc['father_name'],
      motherName: doc['mother_name'],
      mobileNo: doc['mobile_no'],
      attendance: doc['attendance'],
      enrollNo: doc['enrollNo'],
      sem: doc['sem'],
      section: doc['section'],
      branch: doc['branch'],

      //  isVerified: doc['isVerified'],
    );
  }
}

class TodaysLectures extends StatefulWidget {
  final DataBase? database;

  const TodaysLectures({
    Key? key,
    this.database,
  }) : super(key: key);
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
    final usersRef = FirebaseFirestore.instance.collection('users');
    // getting current user document
    DocumentSnapshot doc = await usersRef.doc(widget.database!.id).get();
    if (doc.exists) {
      print('Doc exists');
      AppUser user = AppUser.fromDocument(doc);
      _branch = user.branch;
      _sem = user.sem;
      _section = user.section;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(date?.weekday);
    final AppDataBase appDataBase = Provider.of(context, listen: false);

    String day = DateFormat.EEEE().format(date!);
    UtilityFunctions utility = UtilityFunctions();
    //  print(day);

    return Expanded(
      child: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text(
                    "Today's Lectures",
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
                  child: FutureBuilder<DocumentSnapshot>(
                    future: appDataBase.getLecturesData(
                        branch: _branch, sem: _sem, section: _section),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Something went wrong'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return
                            // Center(
                            //   child: Container(
                            //     height: 80.0,
                            //     width: 90,
                            //     child: Image.asset(
                            //       'assets/loader.gif',
                            //       //fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // );

                            Center(child: CircularProgressIndicator());
                      } else {
                        // checking if documnet exist or not
                        if (snapshot.data?.exists == true) {
                          Map? data = snapshot.data?.data();
                          if (data?.length == 0) {
                            return Center(
                              child: Text(
                                'Nothing Here :)',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            );
                          }

                          final List? today = data?['$day'];
                          if (today == null || today.length == 0) {
                            return Container(
                              height: 90.0,
                              width: 220.0,
                              child: Image.asset('assets/no-data-found.png'),
                            );
                          }
                          return ListView.builder(
                            itemCount: today.length,
                            itemBuilder: (ctx, index) {
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
                                              '${today[index]['subCode']}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.bottomCenter,
                                              child: GestureDetector(
                                                onTap: () {
                                                  utility.launchInBrowser(
                                                      '${today[index]['link']}');
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
                                          '${today[index]['subName']}',
                                          style: TextStyle(fontSize: 17.5),
                                        ),
                                        SizedBox(height: 2.0),
                                        Text(
                                          '${today[index]['time']}',
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Container(
                          height: 90.0,
                          width: 220.0,
                          child: Image.asset('assets/no-data-found.png'),
                        );
                      }
                    },
                  ),
                )
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
