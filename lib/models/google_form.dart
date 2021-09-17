import 'dart:convert';

import 'package:equatable/equatable.dart';

class GoogleForm extends Equatable {
  final String? id;
  final String? title;
  final String? link;

  const GoogleForm({
    this.id,
    this.title,
    this.link,
  });

  @override
  List<Object?> get props => [id, title, link];

  GoogleForm copyWith({
    String? id,
    String? title,
    String? link,
  }) {
    return GoogleForm(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'link': link,
    };
  }

  factory GoogleForm.fromMap(Map<String, dynamic> map) {
    return GoogleForm(
      id: map['id'],
      title: map['title'],
      link: map['link'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GoogleForm.fromJson(String source) =>
      GoogleForm.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
