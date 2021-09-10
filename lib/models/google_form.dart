import 'dart:convert';

import 'package:equatable/equatable.dart';

class GoogleForms extends Equatable {
  final String? title;
  final String? link;
  final String description;
  final DateTime dateTime;

  GoogleForms({
    required this.title,
    required this.link,
    required this.description,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [title, link, description, dateTime];

  GoogleForms copyWith({
    String? title,
    String? link,
    String? description,
    DateTime? dateTime,
  }) {
    return GoogleForms(
      title: title ?? this.title,
      link: link ?? this.link,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'link': link,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory GoogleForms.fromMap(Map<String, dynamic> map) {
    return GoogleForms(
      title: map['title'],
      link: map['link'],
      description: map['description'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GoogleForms.fromJson(String source) =>
      GoogleForms.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
