import 'package:flutter/material.dart';

class OneCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
//  final String? count;
  final Function? onTap;

  const OneCard({
    Key? key,
    this.title,
    this.icon,
    //  this.count,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Card(
        // color: Color.fromRGBO(255, 255, 250, 1),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height < 750 ? 20.0 : 30.0),
            Icon(icon, size: height < 750 ? 30.0 : 40),
            SizedBox(height: 12.0),
            Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: height < 750 ? 15.0 : 30.0),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class OneCard extends StatelessWidget {
//   final String? title;
//   final IconData? icon;
//   final String? count;
//   final Function? onTap;

//   const OneCard({
//     Key? key,
//     this.title,
//     this.icon,
//     this.count,
//     this.onTap,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: onTap as void Function()?,
//           child: Card(
//             color: Color.fromRGBO(255, 255, 250, 1),
//             child: Column(
//               //mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(height: 30.0),
//                 Icon(icon, size: 40),
//                 SizedBox(height: 12.0),
//                 Text(
//                   title!,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18.0,
//                   ),
//                 ),
//                 SizedBox(height: 30.0),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: 10,
//           right: 10,
//           child: Container(
//             padding: EdgeInsets.all(8.0),
//             color: Color.fromRGBO(255, 203, 0, 1),
//             child: Text(
//               '$count',
//               style: TextStyle(),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
