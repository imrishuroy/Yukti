import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String? uid;
  final String? photUrl;
  final String? name;
  //final bool isVerified;
  final String? fatherName;
  final String? motherName;
  final String? mobileNo;
  final String? enrollNo;
  final String? branch;
  final String? sem;
  final int? attendance;
  final String? section;
  const AppUser({
    required this.uid,
    this.photUrl,
    this.name,
    this.fatherName,
    this.motherName,
    this.mobileNo,
    this.enrollNo,
    this.branch,
    this.sem,
    this.attendance,
    this.section,
  });

  AppUser copyWith({
    String? uid,
    String? photUrl,
    String? name,
    String? fatherName,
    String? motherName,
    String? mobileNo,
    String? enrollNo,
    String? branch,
    String? sem,
    int? attendance,
    String? section,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      photUrl: photUrl ?? this.photUrl,
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      mobileNo: mobileNo ?? this.mobileNo,
      enrollNo: enrollNo ?? this.enrollNo,
      branch: branch ?? this.branch,
      sem: sem ?? this.sem,
      attendance: attendance ?? this.attendance,
      section: section ?? this.section,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'photUrl': photUrl,
      'name': name,
      'fatherName': fatherName,
      'motherName': motherName,
      'mobileNo': mobileNo,
      'enrollNo': enrollNo,
      'branch': branch,
      'sem': sem,
      'attendance': attendance,
      'section': section,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      photUrl: map['photUrl'],
      name: map['name'],
      fatherName: map['fatherName'],
      motherName: map['motherName'],
      mobileNo: map['mobileNo'],
      enrollNo: map['enrollNo'],
      branch: map['branch'],
      sem: map['sem'],
      attendance: map['attendance'],
      section: map['section'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      uid,
      photUrl,
      name,
      fatherName,
      motherName,
      mobileNo,
      enrollNo,
      branch,
      sem,
      attendance,
      section,
    ];
  }
}
