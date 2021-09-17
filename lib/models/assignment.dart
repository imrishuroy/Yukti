import 'dart:convert';

import 'package:equatable/equatable.dart';

class Assignment extends Equatable {
  final String? name;
  final String? date;
  final String? link;
  final String? subCode;
  final String? subName;
  final String? assignmentId;

  const Assignment({
    this.name,
    this.date,
    this.link,
    this.subCode,
    this.subName,
    this.assignmentId,
  });

  Assignment copyWith({
    String? name,
    String? date,
    String? link,
    String? subCode,
    String? subName,
    String? assignmentId,
  }) {
    return Assignment(
      name: name ?? this.name,
      date: date ?? this.date,
      link: link ?? this.link,
      subCode: subCode ?? this.subCode,
      subName: subName ?? this.subName,
      assignmentId: assignmentId ?? this.assignmentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'link': link,
      'subCode': subCode,
      'subName': subName,
      'assignmentId': assignmentId,
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      name: map['name'],
      date: map['date'],
      link: map['link'],
      subCode: map['subCode'],
      subName: map['subName'],
      assignmentId: map['assignmentId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Assignment.fromJson(String source) =>
      Assignment.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      name,
      date,
      link,
      subCode,
      subName,
      assignmentId,
    ];
  }
}
