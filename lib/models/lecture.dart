import 'dart:convert';

import 'package:equatable/equatable.dart';

class Lecture extends Equatable {
  final String? profName;
  final String? subCode;
  final String? subName;
  final String? time;
  final String? lectureId;
  final String? link;

  const Lecture({
    this.profName,
    this.subCode,
    this.subName,
    this.time,
    this.lectureId,
    this.link,
  });

  Lecture copyWith({
    String? profName,
    String? subCode,
    String? subName,
    String? time,
    String? lectureId,
    String? link,
  }) {
    return Lecture(
      profName: profName ?? this.profName,
      subCode: subCode ?? this.subCode,
      subName: subName ?? this.subName,
      time: time ?? this.time,
      lectureId: lectureId ?? this.lectureId,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profName': profName,
      'subCode': subCode,
      'subName': subName,
      'time': time,
      'lectureId': lectureId,
      'link': link,
    };
  }

  factory Lecture.fromMap(Map<String, dynamic> map) {
    return Lecture(
      profName: map['profName'],
      subCode: map['subCode'],
      subName: map['subName'],
      time: map['time'],
      lectureId: map['lectureId'],
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
    return [profName, subCode, subName, time, lectureId, link];
  }
}
