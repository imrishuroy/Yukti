import 'package:flutter/material.dart';

class NothingHere extends StatelessWidget {
  final String? appBarTitle;

  const NothingHere({
    Key? key,
    this.appBarTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Nothing Here :(',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(29, 38, 40, 1),
      appBar: AppBar(
        actions: [
          CircleAvatar(
            radius: 14.0,
            backgroundColor: Colors.white,
            child: Text(
              '0',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 20.0),
        ],
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 141, 82, 1),
        title: Text(
          '$appBarTitle',
        ),
      ),
    );
  }
}
