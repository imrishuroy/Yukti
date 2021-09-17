import 'dart:convert';

import 'package:equatable/equatable.dart';

class Gallery extends Equatable {
  final String? imageUrl;
  const Gallery({
    this.imageUrl,
  });

  Gallery copyWith({
    String? imageUrl,
  }) {
    return Gallery(
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
    };
  }

  factory Gallery.fromMap(Map<String, dynamic> map) {
    return Gallery(
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Gallery.fromJson(String source) =>
      Gallery.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [imageUrl];
}
