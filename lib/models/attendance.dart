import 'dart:convert';

import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final String? enrollmentNo;
  final int? attendance;

  const Attendance({
    this.enrollmentNo,
    this.attendance,
  });

  Attendance copyWith({
    String? enrollmentNo,
    int? attendance,
  }) {
    return Attendance(
      enrollmentNo: enrollmentNo ?? this.enrollmentNo,
      attendance: attendance ?? this.attendance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enrollmentNo': enrollmentNo,
      'attendance': attendance,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      enrollmentNo: map['enrollmentNo'],
      attendance: map['attendance'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [enrollmentNo, attendance];
}
