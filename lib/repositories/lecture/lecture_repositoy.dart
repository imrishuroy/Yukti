import 'package:admin_yukti/config/paths.dart';
import 'package:admin_yukti/models/failure.dart';
import 'package:admin_yukti/models/lecture.dart';
import 'package:admin_yukti/repositories/lecture/base_lecture_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LectureRepository extends BaseLectureRepo {
  final FirebaseFirestore _firestore;

  LectureRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addLecture({
    required String branch,
    required String sem,
    required String section,
    required String day,
    required Lecture lecture,
  }) async {
    try {
      String _combineCollection = '$sem-$section-$day';
      await _firestore
          .collection(Paths.lectures)
          .doc(branch)
          .collection(_combineCollection)
          .doc(lecture.lectureId)
          .set(lecture.toMap());
    } catch (error) {
      print('Error adding lecture ${error.toString()}');
      rethrow;
    }
  }
}
