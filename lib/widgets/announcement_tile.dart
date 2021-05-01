// import 'package:flutter/material.dart';

// class AnnouncementTile extends StatelessWidget {
//   final String? title;
//   final String? message;
//   final String? date;

//   const AnnouncementTile({
//     Key? key,
//     this.title,
//     this.message,
//     this.date,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
//           child: Card(
//             child: ListTile(
//               onTap: () {
//                 //   Navigator.pushNamed(context, AnnouncementDetailScreen.routeName);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => AnnouncementDetailScreen(
//                       title: title,
//                       message: message,
//                     ),
//                   ),
//                 );
//               },
//               contentPadding: EdgeInsets.all(10.0),
//               title: Text(
//                 '$title',
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.0),
//                 overflow: TextOverflow.ellipsis,
//               ),
//               subtitle: Text('${message!.substring(0, 74)}...'),
//               trailing: Icon(
//                 Icons.keyboard_arrow_right,
//                 color: Colors.black,
//                 size: 30.0,
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           // right: 12,
//           left: 12,
//           top: 3,
//           child: Container(
//             color: Color.fromRGBO(255, 203, 0, 1),
//             //color: Color.fromRGBO(29, 38, 40, 1),

//             height: 21.0,
//             width: 80.0,
//             child: Center(
//               child: Text(
//                 '$date',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
