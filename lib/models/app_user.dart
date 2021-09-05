import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String? name;
  final String uid;
  final String? dob;
  final String? number;
  final String? email;
  final String? age;
  final String? gender;
  // final List? courses;
  final String? country;
  final String? city;

  AppUser({
    this.name,
    required this.uid,
    this.dob,
    this.number,
    this.email,
    this.age,
    this.gender,
    // this.courses,
    this.city,
    this.country,
  });

  @override
  List<Object?> get props {
    return [
      name,
      uid,
      dob,
      number,
      email,
      age,
      gender,

      /// courses!,
      city,
      country
    ];
  }

  AppUser copyWith({
    String? name,
    String? uid,
    String? dob,
    String? number,
    String? email,
    String? age,
    String? gender,
    //  List? courses,
    String? country,
    String? city,
  }) {
    return AppUser(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      dob: dob ?? this.dob,
      number: number ?? this.number,
      email: email ?? this.email,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      //  courses: courses ?? this.courses,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'dob': dob,
      'number': number,
      'email': email,
      'age': age,
      'gender': gender,
      // 'courses': courses ?? this.courses,
      'city': city ?? this.city,
      'country': country ?? this.country,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'],
      uid: map['uid'],
      dob: map['dob'],
      number: map['number'],
      email: map['email'],
      age: map['age'],
      gender: map['gender'],
      // courses: map['courses'],
      city: map['city'],
      country: map['country'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
