import 'dart:convert';

import 'package:equatable/equatable.dart';

class Lecture extends Equatable {
  final String? profName;
  final String? subCode;
  final String? subName;
  final String? time;
  Lecture({
    this.profName,
    this.subCode,
    this.subName,
    this.time,
  });

  Lecture copyWith({
    String? profName,
    String? subCode,
    String? subName,
    String? time,
  }) {
    return Lecture(
      profName: profName ?? this.profName,
      subCode: subCode ?? this.subCode,
      subName: subName ?? this.subName,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profName': profName,
      'subCode': subCode,
      'subName': subName,
      'time': time,
    };
  }

  factory Lecture.fromMap(Map<String, dynamic> map) {
    return Lecture(
      profName: map['profName'],
      subCode: map['subCode'],
      subName: map['subName'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Lecture.fromJson(String source) =>
      Lecture.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [profName, subCode, subName, time];
}
