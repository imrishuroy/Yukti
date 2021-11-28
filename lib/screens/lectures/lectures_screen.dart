import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'lecture_card.dart';

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

const List<String> weekdays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday'
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
    //final _lecturesRepo = context.read<LecturesRepository>();

    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     final data = await _lecturesRepo.getLecturesList(
        //         branch: branch, sem: sem, section: section, day: 'Monday');

        //     print('Lecture $data');
        //   },
        // ),
        //backgroundColor: const Color.fromRGBO(29, 38, 40, 1),
        appBar: AppBar(
          //  backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
          centerTitle: true,
          title: Text('$branch - $sem Sem ($section)'),
        ),
        body: AnimationLimiter(
          child: ListView.builder(
            itemCount: weekdays.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: LectureCard(
                      day: weekdays[index],
                      branch: branch,
                      section: section,
                      sem: sem,
                    ),
                  ),
                ),
              );
            },
          ),
        )

        // ListView(
        //   children: [
        //     const SizedBox(height: 10.0),
        //     LectureCard(
        //       day: 'Monday',
        //       branch: branch,
        //       section: section,
        //       sem: sem,
        //     ),
        //     const SizedBox(height: 20.0),
        //     LectureCard(
        //       day: 'Tuesday',
        //       branch: branch,
        //       section: section,
        //       sem: sem,
        //     ),
        //     const SizedBox(height: 20.0),
        //     LectureCard(
        //       day: 'Wednesday',
        //       branch: branch,
        //       section: section,
        //       sem: sem,
        //     ),
        //     const SizedBox(height: 20.0),
        //     LectureCard(
        //       day: 'Thursday',
        //       branch: branch,
        //       section: section,
        //       sem: sem,
        //     ),
        //     const SizedBox(height: 20.0),
        //     LectureCard(
        //       day: 'Friday',
        //       branch: branch,
        //       section: section,
        //       sem: sem,
        //     ),
        //     const SizedBox(height: 20.0),
        //     LectureCard(
        //       day: 'Saturday',
        //       branch: branch,
        //       section: section,
        //       sem: sem,
        //     ),
        //   ],
        );

    // FutureBuilder<DocumentSnapshot>(
    //   future:
    //       _lecturesRepo.getLectures(branch: 'CSE', sem: '5th', section: 'B'),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return const Text('Something went wrong');
    //     }

    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const LoadingIndicator();
    //     } else {
    //       final data = snapshot.data?.data() as Map?;

    //       print('Data --------- $data');

    //       if (data != null) {
    //         if (data.isEmpty) {
    //           return const Center(
    //             child: Text(
    //               'Nothing Here :)',
    //               style: TextStyle(
    //                 fontSize: 20.0,
    //                 color: Colors.white,
    //               ),
    //             ),
    //           );
    //         }

    //         // final List? monday = data['Monday'];
    //         // final List? tuesday = data['Tuesday'];
    //         // final List? wednesday = data['Wednesday'];
    //         // final List? thursday = data['Thursday'];
    //         // final List? friday = data['Friday'];
    //         // final List? saturday = data['Saturday'];

    //         //  Text('${data?['Thursday']}'),
    //         return ListView(
    //           children: [
    //             const SizedBox(height: 20.0),
    //             // monday == null
    //             //     ? const LectureCard(
    //             //         lectureList: defaultList,
    //             //         day: 'Monday',
    //             //       )
    //             //     : LectureCard(
    //             //         lectureList: monday.isNotEmpty ? monday : defaultList,
    //             //         day: 'Monday',
    //             //       ),
    //             // const SizedBox(height: 20.0),
    //             // tuesday == null
    //             //     ? const LectureCard(
    //             //         lectureList: defaultList,
    //             //         day: 'Tuesday',
    //             //       )
    //             //     : LectureCard(
    //             //         lectureList:
    //             //             tuesday.isNotEmpty ? tuesday : defaultList,
    //             //         day: 'Tuesday',
    //             //       ),
    //             // const SizedBox(height: 20.0),
    //             // wednesday == null
    //             //     ? const LectureCard(
    //             //         lectureList: defaultList,
    //             //         day: 'Wednesday',
    //             //       )
    //             //     : LectureCard(
    //             //         lectureList:
    //             //             wednesday.isNotEmpty ? wednesday : defaultList,
    //             //         day: 'Wednesday',
    //             //       ),
    //             // const SizedBox(height: 20.0),
    //             // thursday == null
    //             //     ? const LectureCard(
    //             //         lectureList: defaultList,
    //             //         day: 'Thursday',
    //             //       )
    //             //     : LectureCard(
    //             //         lectureList:
    //             //             thursday.isNotEmpty ? thursday : defaultList,
    //             //         day: 'Thursday',
    //             //       ),
    //             // const SizedBox(height: 20.0),
    //             // friday == null
    //             //     ? const LectureCard(
    //             //         lectureList: defaultList,
    //             //         day: 'Friday',
    //             //       )
    //             //     : LectureCard(
    //             //         lectureList: friday.isNotEmpty ? friday : defaultList,
    //             //         day: 'Friday',
    //             //       ),
    //             // const SizedBox(height: 20.0),
    //             // saturday == null
    //             //     ? const LectureCard(
    //             //         lectureList: defaultList,
    //             //         day: 'Saturday',
    //             //       )
    //             //     : LectureCard(
    //             //         lectureList:
    //             //             saturday.isNotEmpty ? saturday : defaultList,
    //             //         day: 'Saturday',
    //             //       ),
    //           ],
    //         );
    //       }

    //       return const Center(
    //         child: Text(
    //           'Nothing Here :)',
    //           style: TextStyle(
    //             fontSize: 20.0,
    //             color: Colors.white,
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // ),
  }
}
