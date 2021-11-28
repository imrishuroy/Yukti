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
