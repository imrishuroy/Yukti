import 'package:flutter/material.dart';

class GreetingsWidget extends StatelessWidget {
  final double height;

  const GreetingsWidget({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Hello',
              style: TextStyle(
                fontSize: height < 750 ? 50.0 : 80.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Text(
                  'There',
                  style: TextStyle(
                    fontSize: height < 750 ? 50.0 : 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  ' !',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}