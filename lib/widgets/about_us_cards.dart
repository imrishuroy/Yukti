import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsCards extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final String? designation;
  final String? instaUrl;
  final String? linkdInUrl;
  final String? avatar;

  const AboutUsCards({
    Key? key,
    this.name,
    this.imageUrl,
    this.designation,
    this.instaUrl,
    this.linkdInUrl,
    this.avatar,
  }) : super(key: key);

  launchUrl(String url, BuildContext context) async {
    try {
      if (await canLaunch(url)) {
        launch(url);
      } else {
        print('Could not connect');
      }
    } on SocketException catch (_) {
      print('Could not connect');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 17.0),
            CircleAvatar(
              radius: 49.0,
              backgroundColor: Colors.white,
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 45.0,
                  backgroundImage: AssetImage(imageUrl!),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              name!,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'AverialLibre',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              designation!,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.linkedin),
                  onPressed: () {
                    launchUrl(linkdInUrl!, context);
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.instagram),
                  onPressed: () {
                    launchUrl(instaUrl!, context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
