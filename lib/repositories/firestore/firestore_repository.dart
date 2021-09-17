import 'package:admin_yukti/config/paths.dart';
import 'package:admin_yukti/models/assignment.dart';
import 'package:admin_yukti/models/google_form.dart';
import 'package:admin_yukti/repositories/firestore/base_firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository extends BaseFirestoreRepository {
  final FirebaseFirestore _firestore;

  FirestoreRepository({FirebaseFirestore? firebaseFirestore})
      : _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> addAssignments({
    required String branch,
    required String sem,
    required String section,
    required Assignment assignment,
  }) async {
    try {
      final collectionPath = '$sem-$section';
      await _firestore
          .collection(Paths.assignments)
          .doc(branch)
          .collection(collectionPath)
          .doc(assignment.assignmentId)
          .set(assignment.toMap());
    } catch (error) {
      print('Error adding assignments ${error.toString()})');
      rethrow;
    }
  }

  Future<void> addGoogleForm({
    required String branch,
    required String sem,
    required String section,
    required GoogleForm form,
  }) async {
    try {
      final collectionPath = '$sem-$section';

      await _firestore
          .collection(Paths.forms)
          .doc(branch)
          .collection(collectionPath)
          .doc(form.id)
          .set(form.toMap());
    } catch (error) {
      print('Error adding google form ${error.toString()}');
      rethrow;
    }
  }
}
