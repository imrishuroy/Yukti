import 'package:flutter/material.dart';
import 'package:yukti/models/announcement.dart';
import 'package:yukti/respositories/firebase/firebase_repositroy.dart';
import 'package:yukti/widgets/nothing_here.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'announcement_tile.dart';

class AnnouncemetScreen extends StatelessWidget {
  static const String routeName = '/announcements';

  static Route route() {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => AnnouncemetScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _firebaseRepo = context.read<FirebaseRepositroy>();
    return FutureBuilder<List<Announcement?>>(
        future: _firebaseRepo.getAnnoucnements(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return NothingHere(
              appBarTitle: 'Announcements',
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final announcements = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Announcements'),
              actions: [
                CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Text(
                    '${announcements?.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: 5.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: announcements?.length,
                    itemBuilder: (context, index) {
                      final announcement = announcements?[index];
                      return AnnouncementTile(
                        announcement: announcement,
                      );
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
