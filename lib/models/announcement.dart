import 'dart:convert';

import 'package:equatable/equatable.dart';

class Announcement extends Equatable {
  final String? message;
  final String? date;
  final String? title;
  Announcement({
    this.message,
    this.date,
    this.title,
  });
  @override
  List<Object?> get props => [message, date, title];

  Announcement copyWith({
    String? message,
    String? date,
    String? title,
  }) {
    return Announcement(
      message: message ?? this.message,
      date: date ?? this.date,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'date': date,
      'title': title,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      message: map['message'],
      date: map['date'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) =>
      Announcement.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
