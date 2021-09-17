import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:yukti/config/paths.dart';
import 'package:yukti/models/failure.dart';
import 'package:yukti/models/lecture.dart';

class LecturesRepository {
  final FirebaseFirestore _firestore;

  LecturesRepository({FirebaseFirestore? firebaseFirestore})
      : _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<List<Lecture?>> getWeekDayLecture({
    required String? branch,
    required String? sem,
    required String? section,
    required String? day,
  }) async {
    print('Branch $branch');
    print('Sem $sem');
    print('Section $section');
    print('Day $day');
    List<Lecture?> lectures = [];
    try {
      final snap = await _firestore
          .collection(Paths.lectures)
          .doc(branch)
          .collection('5th')
          .doc(section)
          .get();

      print('Snap $snap');
      final List data = snap.data()?['$day'];
      print('Data $data');
      for (var element in data) {
        lectures.add(Lecture.fromMap(element));
      }
      return lectures;
    } catch (error) {
      throw const Failure(message: 'Error getting today lecture');
    }
  }

  Future<DocumentSnapshot> getLectures({
    required String? branch,
    required String? sem,
    required String? section,
  }) async {
    try {
      return await _firestore
          .collection(Paths.lectures)
          .doc(branch)
          .collection(sem!)
          .doc(section)
          .get();
    } catch (error) {
      print('Error getting lectures ${error.toString()}');
      rethrow;
    }
  }
}
