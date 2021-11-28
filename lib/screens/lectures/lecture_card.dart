import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/lecture.dart';
import '/respositories/lectures/lectures_repository.dart';

const List<Lecture> errorLectures = [
  Lecture(
      profName: '---------',

      //date: '(**)',
      time: '():--??-??:--()',
      subCode: '----',
      subName: 'Not Available :('),
  Lecture(
      profName: '---------',
      time: '():--??-??:--()',
      subCode: '----',
      subName: 'Not Available :(')
];

class LectureCard extends StatelessWidget {
  final String day;
  final String? sem;

  final String? branch;
  final String? section;

  const LectureCard({
    Key? key,
    required this.day,
    required this.sem,
    required this.branch,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _lectureRepo = context.read<LecturesRepository>();
    return FutureBuilder<List<Lecture?>>(
        future: _lectureRepo.getLecturesList(
            branch: branch, sem: sem, section: section, day: day),
        builder: (context, snapshot) {
          List<Lecture?> lectures = [];

          if (snapshot.hasError) {
            lectures = errorLectures;
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            // return SizedBox(
            //   width: 50.0,
            //   height: 50.0,
            //   child: Shimmer.fromColors(
            //     // baseColor: Colors.red,
            //     // highlightColor: Colors.yellow,
            //     baseColor: Colors.grey.shade300,
            //     highlightColor: Colors.grey.shade100,
            //     direction: ShimmerDirection.ltr,
            //     child: Container(
            //       width: 48.0,
            //       height: 48.0,
            //       color: Colors.white,
            //     ),
            //   ),
            // );
            // Center(
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: const [
            //       SpinKitCircle(
            //         color: Colors.white,
            //       )
            //     ],
            //   ),
            // );
          }

          lectures = snapshot.data ?? [];
          if (lectures.isEmpty) {
            lectures = errorLectures;
          }

          return Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  children: [
                    Text(
                      day,
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        // color: Color.fromRGBO(255, 203, 0, 1),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(width: 4.0),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: lectures.length,
                  itemBuilder: (context, index) {
                    final lecture = lectures[index];
                    return OneLeactureCard(
                      time: lecture?.time ?? '-',
                      profName: lecture?.profName ?? '-',
                      subCode: lecture?.subCode ?? '-',
                      subName: lecture?.subName ?? '-',
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}

class OneLeactureCard extends StatelessWidget {
  final String? time;
  final String? subCode;
  final String? profName;
  final String? subName;

  const OneLeactureCard({
    Key? key,
    this.time,
    this.subCode,
    this.profName,
    this.subName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SizedBox(
        height: 300,
        width: 200,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  color: const Color.fromRGBO(0, 141, 82, 1),
                  child: Text(
                    '$time',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  '$subCode',
                  style: const TextStyle(fontSize: 16.0),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5.0),
                Text(
                  '$subName',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8.0),
                Text(
                  '$profName',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
