import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AppDataBase {
//  lectures.doc('$branch').collection('$sem').doc('$section').get(),
  Future<DocumentSnapshot> getLecturesData({
    String? branch,
    String? sem,
    String? section,
  });

  Stream<QuerySnapshot> galleryStream();
  Stream<DocumentSnapshot> get announcementStream;
}

class FirebaseDataBase implements AppDataBase {
  CollectionReference doc = FirebaseFirestore.instance.collection('lectures');
  final CollectionReference announcementsRef =
      FirebaseFirestore.instance.collection('announcements');

  final CollectionReference? /*!*/ gallery =
      FirebaseFirestore.instance.collection('gallery');
  @override
  Future<DocumentSnapshot> getLecturesData({
    String? branch,
    String? sem,
    String? section,
  }) async {
    return await doc.doc('$branch').collection('$sem').doc('$section').get();
  }

  @override
  Stream<QuerySnapshot> galleryStream() {
    return gallery!.snapshots();
  }

  @override
  Stream<DocumentSnapshot> get announcementStream {
    return announcementsRef.doc('wZJSiOXKuJacCUViCz1B').snapshots();
  }
}
