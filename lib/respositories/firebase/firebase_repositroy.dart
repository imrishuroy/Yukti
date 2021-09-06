import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';

import '/models/gallery.dart';
import '/respositories/firebase/base_firebase_repo.dart';

class FirebaseRepositroy extends BaseFirebaseRepositroy {
  final FirebaseFirestore _firestore;

  FirebaseRepositroy({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Gallery?>> getGalleryImages() async {
    try {
      final snaps = await _firestore
          .collection(Paths.gallery)
          .withConverter<Gallery>(
              fromFirestore: (snapshot, _) => Gallery.fromMap(snapshot.data()!),
              toFirestore: (gallery, _) => gallery.toMap())
          .get();
      return snaps.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error getting gallery images ${e.toString()}');
      throw e;
    }
  }
}
