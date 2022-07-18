import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:attandance_app/model/staff.dart';
import 'package:attandance_app/model/student.dart';

class Course {
  String name;
  String courseCode;
  Staff? staff;
  String totalHoursTaken;
  List<Student>? studnets;
  List<String>? classTakenDates;
  Course({
    required this.name,
    required this.courseCode,
    this.staff,
    required this.totalHoursTaken,
    this.studnets,
    this.classTakenDates,
  });

  Course copyWith({
    String? name,
    String? courseCode,
    Staff? staff,
    String? totalHoursTaken,
    List<Student>? studnets,
    List<String>? classTakenDates,
  }) {
    return Course(
      name: name ?? this.name,
      courseCode: courseCode ?? this.courseCode,
      staff: staff ?? this.staff,
      totalHoursTaken: totalHoursTaken ?? this.totalHoursTaken,
      studnets: studnets ?? this.studnets,
      classTakenDates: classTakenDates ?? this.classTakenDates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'courseCode': courseCode,
      'staff': staff?.toMap(),
      'totalHoursTaken': totalHoursTaken,
      'studnets': studnets?.map((x) => x.toMap()).toList(),
      'classTakenDates': classTakenDates,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'] ?? '',
      courseCode: map['courseCode'] ?? '',
      staff: map['staff'] != null ? Staff.fromMap(map['staff']) : null,
      totalHoursTaken: map['totalHoursTaken'] ?? '',
      studnets: map['studnets'] != null
          ? List<Student>.from(map['studnets']?.map((x) => Student.fromMap(x)))
          : null,
      classTakenDates: map['classTakenDates'] != null
          ? List<String>.from(map['classTakenDates'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course(name: $name, courseCode: $courseCode, staff: $staff, totalHoursTaken: $totalHoursTaken, studnets: $studnets, classTakenDates: $classTakenDates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.name == name &&
        other.courseCode == courseCode &&
        other.staff == staff &&
        other.totalHoursTaken == totalHoursTaken &&
        listEquals(other.studnets, studnets) &&
        listEquals(other.classTakenDates, classTakenDates);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        courseCode.hashCode ^
        staff.hashCode ^
        totalHoursTaken.hashCode ^
        studnets.hashCode ^
        classTakenDates.hashCode;
  }
}
