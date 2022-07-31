import 'dart:convert';

import 'package:flutter/foundation.dart';

class ClassAttandanceModel {
  String className;
  Courses course;
  ClassAttandanceModel({
    required this.className,
    required this.course,
  });

  ClassAttandanceModel copyWith({
    String? className,
    Courses? course,
  }) {
    return ClassAttandanceModel(
      className: className ?? this.className,
      course: course ?? this.course,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'className': className,
      'course': course.toMap(),
    };
  }

  factory ClassAttandanceModel.fromMap(Map<String, dynamic> map) {
    return ClassAttandanceModel(
      className: map['className'] as String,
      course: Courses.fromMap(map['course'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassAttandanceModel.fromJson(String source) =>
      ClassAttandanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ClassAttandanceModel(className: $className, course: $course)';

  @override
  bool operator ==(covariant ClassAttandanceModel other) {
    if (identical(this, other)) return true;

    return other.className == className && other.course == course;
  }

  @override
  int get hashCode => className.hashCode ^ course.hashCode;
}

class Courses {
  String courseName;
  String courseCode;
  List<Students> student;
  Courses({
    required this.courseName,
    required this.courseCode,
    required this.student,
  });

  Courses copyWith({
    String? courseName,
    String? courseCode,
    List<Students>? student,
  }) {
    return Courses(
      courseName: courseName ?? this.courseName,
      courseCode: courseCode ?? this.courseCode,
      student: student ?? this.student,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'courseName': courseName,
      'courseCode': courseCode,
      'student': student.map((x) => x.toMap()).toList(),
    };
  }

  factory Courses.fromMap(Map<String, dynamic> map) {
    return Courses(
      courseName: map['courseName'] as String,
      courseCode: map['courseCode'] as String,
      student: List<Students>.from(
        (map['student'] as List<dynamic>).map<Students>(
          (x) => Students.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Courses.fromJson(String source) =>
      Courses.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Courses(courseName: $courseName, courseCode: $courseCode, student: $student)';

  @override
  bool operator ==(covariant Courses other) {
    if (identical(this, other)) return true;

    return other.courseName == courseName &&
        other.courseCode == courseCode &&
        listEquals(other.student, student);
  }

  @override
  int get hashCode =>
      courseName.hashCode ^ courseCode.hashCode ^ student.hashCode;
}

class Students {
  String name;
  bool isPresent;
  Students({
    required this.name,
    required this.isPresent,
  });

  Students copyWith({
    String? name,
    bool? isPresent,
  }) {
    return Students(
      name: name ?? this.name,
      isPresent: isPresent ?? this.isPresent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isPresent': isPresent,
    };
  }

  factory Students.fromMap(Map<String, dynamic> map) {
    return Students(
      name: map['name'] as String,
      isPresent: map['isPresent'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Students.fromJson(String source) =>
      Students.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Students(name: $name, isPresent: $isPresent)';

  @override
  bool operator ==(covariant Students other) {
    if (identical(this, other)) return true;

    return other.name == name && other.isPresent == isPresent;
  }

  @override
  int get hashCode => name.hashCode ^ isPresent.hashCode;
}
