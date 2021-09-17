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

  const LectureScreen({
    Key? key,
    this.branch,
    this.sem,
    this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _lecturesRepo = context.read<LecturesRepository>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text('$branch - $sem Sem ($section)'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            _lecturesRepo.getLectures(branch: 'CSE', sem: '5th', section: 'B'),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final data = snapshot.data?.data() as Map?;

            if (data != null) {
              if (data.isEmpty) {
                return const Center(
                  child: Text(
                    'Nothing Here :)',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              final List? monday = data['Monday'];
              final List? tuesday = data['Tuesday'];
              final List? wednesday = data['Wednesday'];
              final List? thursday = data['Thursday'];
              final List? friday = data['Friday'];
              final List? saturday = data['Saturday'];

              //  Text('${data?['Thursday']}'),
              return ListView(
                children: [
                  const SizedBox(height: 20.0),
                  monday == null
                      ? const LectureCard(
                          lectureList: defaultList,
                          day: 'Monday',
                        )
                      : LectureCard(
                          lectureList: monday.isNotEmpty ? monday : defaultList,
                          day: 'Monday',
                        ),
                  const SizedBox(height: 20.0),
                  tuesday == null
                      ? const LectureCard(
                          lectureList: defaultList,
                          day: 'Tuesday',
                        )
                      : LectureCard(
                          lectureList:
                              tuesday.isNotEmpty ? tuesday : defaultList,
                          day: 'Tuesday',
                        ),
                  const SizedBox(height: 20.0),
                  wednesday == null
                      ? const LectureCard(
                          lectureList: defaultList,
                          day: 'Wednesday',
                        )
                      : LectureCard(
                          lectureList:
                              wednesday.isNotEmpty ? wednesday : defaultList,
                          day: 'Wednesday',
                        ),
                  const SizedBox(height: 20.0),
                  thursday == null
                      ? const LectureCard(
                          lectureList: defaultList,
                          day: 'Thursday',
                        )
                      : LectureCard(
                          lectureList:
                              thursday.isNotEmpty ? thursday : defaultList,
                          day: 'Thursday',
                        ),
                  const SizedBox(height: 20.0),
                  friday == null
                      ? const LectureCard(
                          lectureList: defaultList,
                          day: 'Friday',
                        )
                      : LectureCard(
                          lectureList: friday.isNotEmpty ? friday : defaultList,
                          day: 'Friday',
                        ),
                  const SizedBox(height: 20.0),
                  saturday == null
                      ? const LectureCard(
                          lectureList: defaultList,
                          day: 'Saturday',
                        )
                      : LectureCard(
                          lectureList:
                              saturday.isNotEmpty ? saturday : defaultList,
                          day: 'Saturday',
                        ),
                ],
              );
            }

            return const Center(
              child: Text(
                'Nothing Here :)',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
