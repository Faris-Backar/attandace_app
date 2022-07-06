import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:attandance_app/model/course.dart';
import 'package:attandance_app/model/student.dart';

class ClassRoom {
  String name;
  String staffAdvicer;
  List<Student> students;
  List<Course> courses;
  ClassRoom({
    required this.name,
    required this.staffAdvicer,
    required this.students,
    required this.courses,
  });

  ClassRoom copyWith({
    String? name,
    String? staffAdvicer,
    List<Student>? students,
    List<Course>? courses,
  }) {
    return ClassRoom(
      name: name ?? this.name,
      staffAdvicer: staffAdvicer ?? this.staffAdvicer,
      students: students ?? this.students,
      courses: courses ?? this.courses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'staffAdvicer': staffAdvicer,
      'students': students.map((x) => x.toMap()).toList(),
      'courses': courses.map((x) => x.toMap()).toList(),
    };
  }

  factory ClassRoom.fromMap(Map<String, dynamic> map) {
    return ClassRoom(
      name: map['name'] ?? '',
      staffAdvicer: map['staffAdvicer'] ?? '',
      students:
          List<Student>.from(map['students']?.map((x) => Student.fromMap(x))),
      courses: List<Course>.from(map['courses']?.map((x) => Course.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassRoom.fromJson(String source) =>
      ClassRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClassRoom(name: $name, staffAdvicer: $staffAdvicer, students: $students, courses: $courses)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassRoom &&
        other.name == name &&
        other.staffAdvicer == staffAdvicer &&
        listEquals(other.students, students) &&
        listEquals(other.courses, courses);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        staffAdvicer.hashCode ^
        students.hashCode ^
        courses.hashCode;
  }
}
