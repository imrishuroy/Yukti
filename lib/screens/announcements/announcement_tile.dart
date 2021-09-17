import 'package:flutter/material.dart';
import 'package:yukti/models/announcement.dart';
import 'package:yukti/respositories/repositories.dart';

class AnnouncementTile extends StatelessWidget {
  final Announcement? announcement;

  const AnnouncementTile({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          child: Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnnouncementDetailScreen(
                      title: announcement?.title,
                      message: announcement?.message,
                    ),
                  ),
                );
              },
              contentPadding: const EdgeInsets.all(10.0),
              title: Text(
                '${announcement?.title}',
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 17.0),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text('${announcement?.message?.substring(0, 74)}...'),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
                size: 30.0,
              ),
            ),
          ),
        ),
        Positioned(
          // right: 12,
          left: 12,
          top: 3,
          child: Container(
            color: const Color.fromRGBO(255, 203, 0, 1),
            //color: Color.fromRGBO(29, 38, 40, 1),

            height: 21.0,
            width: 80.0,
            child: Center(
              child: Text(
                '${announcement?.date}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        )
      ],
    );
  }
}
