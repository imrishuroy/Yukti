import 'dart:convert';

import 'package:equatable/equatable.dart';

class Lecture extends Equatable {
  final String lectureId;
  final String? profName;
  final String? subCode;
  final String? subName;
  final String? time;
  final String? link;

  const Lecture({
    required this.lectureId,
    this.profName,
    this.subCode,
    this.subName,
    this.time,
    this.link,
  });

  Lecture copyWith({
    String? lectureId,
    String? profName,
    String? subCode,
    String? subName,
    String? time,
    String? link,
  }) {
    return Lecture(
      lectureId: lectureId ?? this.lectureId,
      profName: profName ?? this.profName,
      subCode: subCode ?? this.subCode,
      subName: subName ?? this.subName,
      time: time ?? this.time,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lectureId': lectureId,
      'profName': profName,
      'subCode': subCode,
      'subName': subName,
      'time': time,
      'link': link,
    };
  }

  factory Lecture.fromMap(Map<String, dynamic> map) {
    return Lecture(
      lectureId: map['lectureId'],
      profName: map['profName'],
      subCode: map['subCode'],
      subName: map['subName'],
      time: map['time'],
      link: map['link'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Lecture.fromJson(String source) =>
      Lecture.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      lectureId,
      profName,
      subCode,
      subName,
      time,
      link,
    ];
  }
}
