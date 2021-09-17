import 'dart:convert';

import 'package:equatable/equatable.dart';

class GoogleForm extends Equatable {
  final String? formId;
  final String? title;
  final String? link;
  final String? description;
  final DateTime dateTime;

  const GoogleForm({
    required this.formId,
    required this.title,
    required this.link,
    required this.description,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [formId, title, link, description, dateTime];

  GoogleForm copyWith({
    String? formId,
    String? title,
    String? link,
    String? description,
    DateTime? dateTime,
  }) {
    return GoogleForm(
      formId: formId ?? this.formId,
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

  factory GoogleForm.fromMap(Map<String, dynamic> map) {
    return GoogleForm(
      formId: map['formId'],
      title: map['title'],
      link: map['link'],
      description: map['description'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GoogleForm.fromJson(String source) =>
      GoogleForm.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
