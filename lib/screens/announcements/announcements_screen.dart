import 'package:flutter/material.dart';
import 'package:yukti/models/announcement.dart';
import 'package:yukti/respositories/firebase/firebase_repositroy.dart';
import 'package:yukti/widgets/nothing_here.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'announcement_tile.dart';

class AnnouncemetScreen extends StatelessWidget {
  static const String routeName = '/announcements';

  const AnnouncemetScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => const AnnouncemetScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _firebaseRepo = context.read<FirebaseRepositroy>();
    return FutureBuilder<List<Announcement?>>(
      future: _firebaseRepo.getAnnoucnements(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const NothingHere(
            appBarTitle: 'Announcements',
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final announcements = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Announcements'),
            actions: [
              CircleAvatar(
                radius: 14.0,
                backgroundColor: Colors.white,
                child: Text(
                  '${announcements?.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
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
      },
    );
  }
}
