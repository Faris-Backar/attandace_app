import 'dart:convert';

import 'package:flutter/foundation.dart';

// import 'package:attandance_app/model/attandance_model.dart';
import 'package:attandance_app/model/staff.dart';
import 'package:attandance_app/model/student.dart';

class Course {
  String name;
  String courseCode;
  Staff? staff;
  List<Student>? students;
  String totalHoursTaken;
  Course({
    required this.name,
    required this.courseCode,
    this.staff,
    this.students,
    required this.totalHoursTaken,
  });

  Course copyWith({
    String? name,
    String? courseCode,
    Staff? staff,
    List<Student>? students,
    String? totalHoursTaken,
  }) {
    return Course(
      name: name ?? this.name,
      courseCode: courseCode ?? this.courseCode,
      staff: staff ?? this.staff,
      students: students ?? this.students,
      totalHoursTaken: totalHoursTaken ?? this.totalHoursTaken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'courseCode': courseCode,
      'staff': staff?.toMap(),
      'students': students?.map((x) => x.toMap()).toList(),
      'totalHoursTaken': totalHoursTaken,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'] ?? '',
      courseCode: map['courseCode'] ?? '',
      staff: map['staff'] != null ? Staff.fromMap(map['staff']) : null,
      students: map['students'] != null
          ? List<Student>.from(map['students']?.map((x) => Student.fromMap(x)))
          : null,
      totalHoursTaken: map['totalHoursTaken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course(name: $name, courseCode: $courseCode, staff: $staff, students: $students, totalHoursTaken: $totalHoursTaken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.name == name &&
        other.courseCode == courseCode &&
        other.staff == staff &&
        listEquals(other.students, students) &&
        other.totalHoursTaken == totalHoursTaken;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        courseCode.hashCode ^
        staff.hashCode ^
        students.hashCode ^
        totalHoursTaken.hashCode;
  }
}
