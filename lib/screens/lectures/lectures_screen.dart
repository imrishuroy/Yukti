import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yukti/respositories/lectures/lectures_repository.dart';

import 'lecture_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List defaultList = [
  {
    'day': 'Not-available',
    'date': '(**)',
    'time': '():--??-??:--()',
    'subCode': '----',
    'profName': '---------',
    'subName': '--'
  },
];

class LectureScreen extends StatelessWidget {
  final String? branch;
  final String? sem;
  final String? section;

  LectureScreen({
    Key? key,
    this.branch,
    this.sem,
    this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _lecturesRepo = context.read<LecturesRepository>();

    return Scaffold(
      backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text('$branch - $sem Sem ($section)'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            _lecturesRepo.getLectures(branch: 'CSE', sem: '5th', section: 'B'),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final data = snapshot.data?.data() as Map?;
            if (data?.length == 0) {
              return Center(
                child: Text(
                  'Nothing Here :)',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              );
            }
            final List? monday = data?['Monday'];
            final List? tuesday = data?['Tuesday'];
            final List? wednesday = data?['Wednesday'];
            final List? thursday = data?['Thursday'];
            final List? friday = data?['Friday'];
            final List? saturday = data?['Saturday'];

            //  Text('${data?['Thursday']}'),
            return ListView(
              children: [
                SizedBox(height: 20.0),
                monday == null
                    ? LectureCard(
                        lectureList: defaultList,
                        day: 'Monday',
                      )
                    : LectureCard(
                        lectureList: monday.length != 0 ? monday : defaultList,
                        day: 'Monday',
                      ),
                SizedBox(height: 20.0),
                tuesday == null
                    ? LectureCard(
                        lectureList: defaultList,
                        day: 'Tuesday',
                      )
                    : LectureCard(
                        lectureList:
                            tuesday.length != 0 ? tuesday : defaultList,
                        day: 'Tuesday',
                      ),
                SizedBox(height: 20.0),
                wednesday == null
                    ? LectureCard(
                        lectureList: defaultList,
                        day: 'Wednesday',
                      )
                    : LectureCard(
                        lectureList:
                            wednesday.length != 0 ? wednesday : defaultList,
                        day: 'Wednesday',
                      ),
                SizedBox(height: 20.0),
                thursday == null
                    ? LectureCard(
                        lectureList: defaultList,
                        day: 'Thursday',
                      )
                    : LectureCard(
                        lectureList:
                            thursday.length != 0 ? thursday : defaultList,
                        day: 'Thursday',
                      ),
                SizedBox(height: 20.0),
                friday == null
                    ? LectureCard(
                        lectureList: defaultList,
                        day: 'Friday',
                      )
                    : LectureCard(
                        lectureList: friday.length != 0 ? friday : defaultList,
                        day: 'Friday',
                      ),
                SizedBox(height: 20.0),
                saturday == null
                    ? LectureCard(
                        lectureList: defaultList,
                        day: 'Saturday',
                      )
                    : LectureCard(
                        lectureList:
                            saturday.length != 0 ? saturday : defaultList,
                        day: 'Saturday',
                      ),
              ],
            );
          }
        },
      ),
    );
  }
}
