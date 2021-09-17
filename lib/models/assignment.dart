import 'dart:convert';

import 'package:equatable/equatable.dart';

class Assignment extends Equatable {
  final String? assignmentId;
  final String? date;
  final String? link;
  final String? name;
  final String? subCode;
  final String? subName;

  const Assignment({
    required this.assignmentId,
    required this.date,
    required this.link,
    required this.name,
    required this.subCode,
    required this.subName,
  });

  Assignment copyWith({
    String? assignmentId,
    String? date,
    String? link,
    String? name,
    String? subCode,
    String? subName,
  }) {
    return Assignment(
      assignmentId: assignmentId ?? this.assignmentId,
      date: date ?? this.date,
      link: link ?? this.link,
      name: name ?? this.name,
      subCode: subCode ?? this.subCode,
      subName: subName ?? this.subName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'assignmentId': assignmentId,
      'date': date,
      'link': link,
      'name': name,
      'subCode': subCode,
      'subName': subName,
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      assignmentId: map['assignmentId'],
      date: map['date'],
      link: map['link'],
      name: map['name'],
      subCode: map['subCode'],
      subName: map['subName'],
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
      assignmentId,
      date,
      link,
      name,
      subCode,
      subName,
    ];
  }
}
