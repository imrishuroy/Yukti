import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:yukti/models/app_user.dart';
import '/models/lecture.dart';
import '/respositories/lectures/lectures_repository.dart';

class TodaysLectures extends StatelessWidget {
  final AppUser? user;

  const TodaysLectures({Key? key, required this.user}) : super(key: key);
  //final DateTime? date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // print('${context.read<ProfileBloc>().state.user?.branch}-----------');
    final _lectureRepo = context.read<LecturesRepository>();
    final date = DateTime.now();

    String day = DateFormat.EEEE().format(date);

    //String day = 'Monday';
    //  UtilityFunctions utility = UtilityFunctions();
    //  print(day);

    return Expanded(
      child: FutureBuilder<List<Lecture?>>(
        future: _lectureRepo.getWeekDayLecture(
          branch: user?.branch,
          sem: user?.sem,
          section: user?.section,
          day: day,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          print('Lecture------- ${snapshot.data}');

          if (snapshot.data == null) {
            return const Center(
              child: Text(
                'Nothing Here : )',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nothing Here : )',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                const Chip(
                                  backgroundColor:
                                      Color.fromRGBO(40, 200, 253, 1),
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
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
