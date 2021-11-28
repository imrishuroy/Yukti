import 'package:flutter/material.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  static String routeName = '/announcement-detail';
  final String? title;
  final String? message;

  const AnnouncementDetailScreen({
    Key? key,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromRGBO(29, 38, 40, 1),
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: const Color.fromRGBO(0, 141, 82, 1),
      //   title: const Text('Details'),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                '$title',
                style: const TextStyle(
                  fontSize: 22.0,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(255, 203, 0, 1),
                ),
              ),
            ),
            Padding(
              padding:
                  // const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 14.0),
              child: Text(
                message!,
                style: const TextStyle(
                  fontFamily: 'NotoSerif',
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
