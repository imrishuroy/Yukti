import 'package:flutter/material.dart';

Container greetingWidget(double height) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 60.0),
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
              Text(
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

// Container greetingWidget() {
//   return Container(
//     child: Flex(
//       direction: Axis.vertical,
//       children: [
//         Stack(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(15.0, 95.0, 0.0, 0.0),
//                 child: Text(
//                   'Hello',
//                   style: TextStyle(
//                     fontSize: 80.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(17.0, 175.0, 0.0, 0.0),
//                 child: Text(
//                   'There',
//                   style: TextStyle(
//                     fontSize: 80.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(230.0, 203.0, 0.0, 0.0),
//                 child: Text(
//                   ' !',
//                   style: TextStyle(
//                     fontSize: 50.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ],
//     ),
//   );
// }
