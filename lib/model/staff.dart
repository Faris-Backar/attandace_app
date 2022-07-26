import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:attandance_app/model/course.dart';

class Staff {
  String? uid;
  String name;
  String email;
  String branch;
  List<Course>? assignedCourses;
  String? assignedClass;
  Staff({
    this.uid,
    required this.name,
    required this.email,
    required this.branch,
    this.assignedCourses,
    this.assignedClass,
  });

  Staff copyWith({
    String? uid,
    String? name,
    String? email,
    String? branch,
    List<Course>? assignedCourses,
    String? assignedClass,
  }) {
    return Staff(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      branch: branch ?? this.branch,
      assignedCourses: assignedCourses ?? this.assignedCourses,
      assignedClass: assignedClass ?? this.assignedClass,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'branch': branch,
      'assignedCourses': assignedCourses?.map((x) => x.toMap()).toList(),
      'assignedClass': assignedClass,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      branch: map['branch'] ?? '',
      assignedCourses: map['assignedCourses'] != null
          ? List<Course>.from(
              map['assignedCourses']?.map((x) => Course.fromMap(x)))
          : null,
      assignedClass: map['assignedClass'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Staff(uid: $uid, name: $name, email: $email, branch: $branch, assignedCourses: $assignedCourses, assignedClass: $assignedClass)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Staff &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.branch == branch &&
        listEquals(other.assignedCourses, assignedCourses) &&
        other.assignedClass == assignedClass;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        branch.hashCode ^
        assignedCourses.hashCode ^
        assignedClass.hashCode;
  }
}
