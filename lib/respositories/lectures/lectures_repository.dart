import 'package:cloud_firestore/cloud_firestore.dart';

import '/config/paths.dart';
import '/models/failure.dart';
import '/models/lecture.dart';

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

    try {
      final snap = await _firestore
          .collection(Paths.lectures)
          .doc(branch)
          .collection('$sem-$section-$day')
          .orderBy('time')
          .withConverter<Lecture>(
              fromFirestore: (snapshot, _) => Lecture.fromMap(snapshot.data()!),
              toFirestore: (lecture, _) => lecture.toMap())
          .get();
      print('All lectures ${snap.docs.map((snap) => snap.data()).toList()}');

      return snap.docs.map((snap) => snap.data()).toList();
    } catch (error) {
      throw const Failure(message: 'Error getting today lecture');
    }
  }

  Future<List<Lecture?>> getLecturesList({
    required String? branch,
    required String? sem,
    required String? section,
    required String? day,
  }) async {
    try {
      List<Lecture?> lectures = [];
      if (branch == null || section == null || sem == null) {
        return lectures;
      }

      String path = '$sem-$section-$day';
      // print('Path $path');

      final data = await _firestore
          .collection(Paths.lectures)
          .doc(branch)
          .collection(path)
          .get();

      for (var element in data.docs) {
        print('Element ${element.data()}');
        lectures.add(Lecture.fromMap(element.data()));
      }

      return lectures;
    } catch (error) {
      print('Error in getting lectures list ${error.toString()}');
      rethrow;
    }
  }

  Future<DocumentSnapshot> getLectures({
    required String? branch,
    required String sem,
    required String? section,
  }) async {
    try {
      final data = _firestore
          .collection(Paths.lectures)
          .doc('CSE')
          .collection('5th-B-Monday')
          .snapshots();
      data.forEach((n) {
        print('N ${n.docs.first.data()}');
      });

      // .get();

      print('Data $data');

      return await _firestore
          .collection(Paths.lectures)
          .doc(branch)
          .collection('5th-B-Monday')
          .doc(section)
          .get();
    } catch (error) {
      print('Error getting lectures ${error.toString()}');
      rethrow;
    }
  }
}
