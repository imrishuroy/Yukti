import 'package:flutter/material.dart';

class BuildOneLeactureDay extends StatelessWidget {
  // final String? day;
  // final String? lectureDate;
  final List? lectureList;
  final String? day;

  const BuildOneLeactureDay({
    Key? key,
    // this.day,
    // this.lectureDate,
    this.lectureList,
    this.day,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final String? day = '${lectureList?[0]['day']}' ?? null;
    // final String? date = '${lectureList?[0]['date']}' ?? null;
    // final String? day = lectureList?[0]['day'] ?? null;

    // final String? date = lectureList?[0]['date'] ?? null;
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            children: [
              day != null
                  ? Text(
                      '$day',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        // color: Color.fromRGBO(255, 203, 0, 1),
                      ),
                      textAlign: TextAlign.start,
                    )
                  : Text('-'),
              SizedBox(width: 4.0),
              // date != null
              //     ? Text(
              //         '$date',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       )
              //     : Text('-'),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lectureList?.length,
            itemBuilder: (context, index) {
              return OneLeactureCard(
                time: lectureList?[index]['time'] ?? '-',
                profName: lectureList?[index]['profName'] ?? '-',
                subCode: lectureList?[index]['subCode'] ?? '-',
                subName: lectureList?[index]['subName'] ?? '-',
              );
            },
          ),
        ),
      ],
      // ),
    );
  }
}

class OneLeactureCard extends StatelessWidget {
  final String? time;
  final String? subCode;
  final String? profName;
  final String? subName;

  const OneLeactureCard({
    Key? key,
    this.time,
    this.subCode,
    this.profName,
    this.subName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SizedBox(
        height: 300,
        width: 200,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  color: Color.fromRGBO(0, 141, 82, 1),
                  child: Text(
                    '$time',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '$subCode',
                  style: TextStyle(fontSize: 16.0),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.0),
                Text(
                  '$subName',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.0),
                Text(
                  '$profName',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class BuildOneLeactureDay extends StatelessWidget {
//   final String? day;
//   final String? lectureDate;
//   final List? lectureList;

//   const BuildOneLeactureDay({
//     Key? key,
//     this.day,
//     this.lectureDate,
//     this.lectureList,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           alignment: Alignment.topLeft,
//           padding: const EdgeInsets.symmetric(horizontal: 23.0),
//           child: Row(
//             children: [
//               Text(
//                 '$day',
//                 style: TextStyle(fontSize: 25.0),
//                 textAlign: TextAlign.start,
//               ),
//               SizedBox(width: 4.0),
//               Text(
//                 '08/12',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                 ),
//               )
//             ],
//           ),
//         ),
//         SizedBox(height: 10.0),
//         SizedBox(
//           height: 120,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: lectureList?.length,
//             itemBuilder: (context, index) {
//               return OneLeactureCard(
//                 time: '${lectureList?[index]['time']}',
//                 profName: lectureList?[index]['profName'],
//                 subCode: lectureList?[index]['subCode'],
//                 subName: lectureList?[index]['subName'],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class OneLeactureCard extends StatelessWidget {
//   final String? time;
//   final String? subCode;
//   final String? profName;
//   final String? subName;

//   const OneLeactureCard({
//     Key? key,
//     this.time,
//     this.subCode,
//     this.profName,
//     this.subName,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 8.0,
//                 vertical: 4.0,
//               ),
//               color: Color.fromRGBO(0, 141, 82, 1),
//               child: Text(
//                 time!,
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text('$subCode', style: TextStyle(fontSize: 16.0)),
//             Text(
//               subName!,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 4.0),
//             Text(
//               '$profName',
//               style: TextStyle(
//                 color: Colors.orange,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 1.1,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
