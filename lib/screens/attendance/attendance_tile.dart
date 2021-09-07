import 'package:flutter/material.dart';

class SubjectAttendanceTileOld extends StatelessWidget {
  final String? subCode;
  final String? subName;
  final String? facultyName;
  final Color? color;

  const SubjectAttendanceTileOld({
    Key? key,
    this.subCode,
    this.subName,
    this.facultyName,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(10.0, 7.0, 20.0, 7.0),
          title: Text(
            '$subCode',
            style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1.1),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.0),
              Text('Subject - $subName'),
              SizedBox(height: 1.0),
              Text('Faculty - $facultyName')
            ],
          ),
          trailing: CircleAvatar(
            radius: 15.0,
            backgroundColor: color,
          ),
        ),
      ),
    );
  }
}

class SubjectIndicator extends StatelessWidget {
  final String? subCode;
  final String? subName;
  final Color? color;

  const SubjectIndicator({
    Key? key,
    this.subCode,
    this.subName,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '* $subCode ($subName)',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 15.0),
          Container(
            height: 30.0,
            width: 30.0,
            color: color,
          ),
          SizedBox(width: 10.0),
        ],
      ),
    );
  }
}

class DisplayTotalAttendanceCardOld extends StatelessWidget {
  final int? totalAttendance;

  const DisplayTotalAttendanceCardOld({Key? key, this.totalAttendance})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Attendance',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.orangeAccent,
                height: 32.0,
                width: 63.0,
                child: Text(
                  '$totalAttendance %',
                  style: TextStyle(
                    fontSize: 18.5,
                    //  color: Colors.white,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
