import 'package:flutter/material.dart';

class HappeningDetailScreen extends StatelessWidget {
  static String routeName = '/happening-details';
  final String? imageUrl;
  final String? title;
  final String? description;

  const HappeningDetailScreen({
    Key? key,
    this.imageUrl,
    this.title,
    this.description,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        centerTitle: true,
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    '$imageUrl',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, right: 10.0),
              // symmetric(
              //   horizontal: 20.0,
              //   vertical: 12.0,
              // ),
              child: Text(
                '$title',
                style: TextStyle(
                  color: Color.fromRGBO(255, 203, 0, 1),
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12.0,
              ),
              child: Text(
                '$description',
                style: TextStyle(
                  fontFamily: 'NotoSerif',
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                  // fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
